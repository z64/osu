require "json"
require "./mappings/*"

module Osu
  # An implementation of Osu::API to request and serve
  # data objects from the API in a useful way
  class Client
    getter key : String

    def initialize(@key)
    end

    def user(id : String | Int32, mode : Int32? = nil, event_days : Int32? = nil)
      user_hash = Helper.user(id)

      User.from_json API.user(
        @key,
        user_hash.merge({"m" => mode, "event_days" => event_days}).compact
      )
    end
  end
end
