require "json"
require "./api"
require "./mappings/*"

module Osu
  # An implementation of Osu::API to request and serve
  # data objects from the API in a useful way
  class Client
    getter key : String

    def initialize(@key)
    end

    # Request a single user object for a given game mode
    def user(id : String | Int32, mode : API::Mode = API::Mode::Standard, event_days : Int32? = nil)
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
    def user(id : String | Int32, mode : Array(API::Mode), event_days : Int32? = nil)
      channel = Channel(User).new

      mode.each do |m|
        spawn { channel.send user(id, m, event_days) }
      end

      mode.map { |e| channel.receive }
    end

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
    def beatmaps(user : String | Int32, mode : API::Mode? = nil, limit : Int32 = 500)
      response = API.beatmaps(
        @key,
        API::RequestParameters{
          :user  => user,
          :mode  => mode,
          :limit => limit,
        }.params
      )

      objects = [] of Beatmap
      parser = JSON::PullParser.new(response)
      parser.read_array do
        objects << Beatmap.from_json(parser.read_raw)
      end

      objects
    end
  end
end
