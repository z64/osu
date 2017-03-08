require "json"
require "string_converter"
require "./mappings/*"

module Osu
  # An implementation of Osu::API to request and serve
  # data objects from the API in a useful way
  class Client
    getter key : String

    def initialize(@key)
    end

    # Request a single user object for a given game mode
    def user(id : String | Int32, mode : Int32? = 0, event_days : Int32? = nil)
      user_hash = Helper.user(id)

      User.from_json API.user(
        @key,
        user_hash.merge({"m" => mode, "event_days" => event_days})
      )
    end

    # Asynchronously loads user stats for multiple game modes.
    def user(id : String | Int32, mode : Array(Int32), event_days : Int32? = nil) : Array(User)
      futures = [] of Concurrent::Future(User)

      mode.each { |m| futures << future { user(id, m, event_days) } }

      futures.map { |f| f.get }
    end
  end
end
