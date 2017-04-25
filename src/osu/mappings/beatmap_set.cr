module Osu
  struct BeatmapSet
    # ID of the beatmap set
    getter id : UInt32

    # Beatmaps contained in this set
    getter beatmaps = [] of Beatmap

    # Initialize a new `BeatmapSet` with an array of `Beatmap`.
    # This sets ID and other properties will be derived from the first
    # beatmap in the set.
    def initialize(@beatmaps : Array(Beatmap))
      @id = @beatmaps.first.beatmapset_id.as(UInt32)
    end

    # Define a series of getters to common properties across
    # all beatmaps in a set. No assertion is done here and all
    # values are taken from the first beatmap, so these values
    # should only be used on responses from the API.
    {% for common_property in ["approval", "mode", "artist", "title", "creator", "source"] %}
      # The beatmaps {{common_property}} property, which is shared across beatmaps within a set
      def {{common_property.id}}
        @beatmaps.first.{{common_property.id}}
      end
    {% end %}

    # URL to this beatmap set
    def url
      "#{API::BASE_URL}/s/#{id}"
    end

    def self.from_json(string : String)
      parser = JSON::PullParser.new(string)

      beatmaps = [] of Beatmap

      parser.read_array do
        beatmaps << Beatmap.from_json parser.read_raw
      end

      new beatmaps
    end
  end
end
