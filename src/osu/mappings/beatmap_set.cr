require "./beatmap"

module Osu
  struct BeatmapSet
    getter beatmaps = [] of Beatmap

    def initialize(@beatmaps)
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
