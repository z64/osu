require "./enum"

module Osu
  module API
    # Symbol to String table for decoding
    # user-friendly hash constructor arguments
    # for HTTP parameters
    Parameters = {
      :key            => "k",
      :user           => "u",
      :beatmap        => "b",
      :set            => "s",
      :mode           => "m",
      :event_days     => "event_days",
      :type           => "type",
      :mods           => "mods",
      :limit          => "limit",
      :converted_maps => "a",
      :hash           => "h",
      :since          => "since",
      :match_id       => "mp",
    }

    # An object that constructs a querystring ah that can be passed
    # to the API module.
    struct RequestParameters
      getter params = {} of String => String

      # Sets a certain request field.
      # This will automatically convert values to strings for use with
      # Cossack, as well as automatically setting the "type" parameter
      # if setting a user value. If you supply a symbol, it will perform a
      # lookup in Parameters for the apropriate API query key. If you supply
      # the `:mods` symbol, it will be passed as an argument to `Mods.bits`
      def []=(key : Symbol | String, value)
        return unless value

        case key
        when :user
          @params["type"] = if value.is_a? String
                              "name"
                            else
                              "id"
                            end
        when :mods && :mode
          value = value.try &.to_i.to_s
        end

        parameter = if key.is_a?(Symbol)
                      Parameters[key]? || key.to_s
                    else
                      key
                    end

        @params[parameter] = value.to_s
      end
    end
  end
end
