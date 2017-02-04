module Osu
  module Helper
    extend self

    # Returns a user-like hash by username
    def user(data : String)
      {"u" => data, "type" => "string"}
    end

    # Returns a user-like hash by user ID
    def user(data : Int32)
      {"u" => data, "type" => "id"}
    end
  end
end
