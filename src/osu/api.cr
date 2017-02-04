require "cossack"

module Osu
  # This module provides an interface to Osu's REST API
  module API
    extend self
    # URL to Osu services
    BASE_URL = "https://osu.ppy.sh"

    # Cossack client to the API
    CLIENT = Cossack::Client.new "#{BASE_URL}/api"

    # Creates a GET endpoint to use with the API.
    # If `single = true`, this will trim the surrounding braces
    # of the JSON response so it returns a single object.
    # This is useful for endpoints that *should* only ever return a
    # single object, but ship inside an array anyways.
    macro get(route, single = false)
      def {{route}}(key : String, params : Hash(String, String | Int32)) : String
        params["k"] = key

        string_params = Cossack::Params.new
        params.each { |k, v| string_params[k] = "#{v}" }

        response = CLIENT.get "get_{{route}}", string_params.compact

        {% if single %}
          response.body[1..-2]
        {% else %}
          response.body
        {% end %}
      end
    end

    # Request a user object
    get user, true

    # Request a beatmap object
    get beatmaps

    # Request the top scores for a beatmap
    get scores

    # Request a user's top scores
    get user_best

    # Request a user's most recent scores
    get user_recent

    # Request multiplayer match data
    get match, true

    # Request match replay data
    get replay
  end
end
