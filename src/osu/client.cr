require "json"
require "./api"
require "./api/*"
require "./mappings"

module Osu
  # Alias to API::Mode. Just removes some typing,
  # I may move the enums out of the API namespace
  # in the future. For now this retains future compatibility.
  alias Mode = API::Mode

  # User ID union type
  alias UserID = String | Int32

  # An implementation of Osu::API to request and serve
  # data objects from the API in a useful way
  class Client
    # API key
    getter key : String

    def initialize(@key)
    end

    # :nodoc:
    macro read_array(container, response, typ)
      {{container}} = [] of {{typ}}
      parser = JSON::PullParser.new({{response}})
      parser.read_array do
        {{container}} << {{typ}}.from_json(parser.read_raw)
      end

      {{container}}
    end

    # Request a single user object for a given game mode
    def user(id : UserID, mode : API::Mode = API::Mode::Standard, event_days : Int32? = nil)
      User.from_json API.user(
        @key,
        API::RequestParameters{
          :user       => id,
          :mode       => mode,
          :event_days => event_days,
        }.params
      )
    end

    # Asynchronously loads user stats for multiple game modes.
    def user(id : UserID, mode : Array(API::Mode), event_days : Int32? = nil)
      channel = Channel(User).new

      mode.each do |m|
        spawn { channel.send user(id, m, event_days) }
      end

      mode.map { |e| channel.receive }
    end

    {% for score in ["user_best", "user_recent"] %}
      def {{score.id}}(user : UserID, mode : API::Mode = API::Mode::Standard, limit : Int32? = nil)
        {% if score == "user_best" %}
          response = API.user_best(
        {% end %}
        {% if score == "user_recent" %}
          response = API.user_recent(
        {% end %}
          @key,
          API::RequestParameters{
            :user  => user,
            :mode  => mode,
            :limit => limit,
          }.params
        )

        objects = [] of Score
        read_array objects, response, Score
      end
    {% end %}

    # Get a beatmap object by ID
    def beatmap(id : Int32, mode : API::Mode? = nil)
      response = API.beatmaps(
        @key,
        API::RequestParameters{
          :beatmap => id,
          :mode    => mode,
        }.params
      )

      return if response == "[]"
      Beatmap.from_json response[1..-2]
    end

    # Look up beatmaps with certain criteria
    def beatmaps(user : UserID? = nil, mode : API::Mode? = nil, limit : Int32? = nil)
      response = API.beatmaps(
        @key,
        API::RequestParameters{
          :user  => user,
          :mode  => mode,
          :limit => limit,
        }.params
      )

      objects = [] of Beatmap
      read_array objects, response, Beatmap
    end

    # Obtain a collection of beatmaps under a set
    def beatmap_set(id : Int32)
      response = API.beatmaps(
        @key,
        API::RequestParameters{
          :set => id,
        }.params
      )

      return if response == "[]"

      BeatmapSet.from_json response
    end
  end
end
