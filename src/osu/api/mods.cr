module Osu
  module API
    module Mods
      extend self

      # A hashmap of Osu game mods
      MODS = {
         0 => :no_fail,      # 1
         1 => :easy,         # 2
         2 => :no_video,     # 4
         3 => :hidden,       # 8
         4 => :hard_rock,    # 16
         5 => :sudden_death, # 32
         6 => :double_time,  # 64
         7 => :relax,        # 128
         8 => :half_time,    # 256
         9 => :nightcore,    # 512
        10 => :flashlight,   # 1024
        11 => :autoplay,     # 2048
        12 => :spun_out,     # 4096
        13 => :relax2,       # 8192
        14 => :perfect,      # 16384
        16 => :key4,         # 32768
        17 => :key5,         # 65536
        18 => :key6,         # 131072
        19 => :key7,         # 262144
        20 => :key8,         # 524288
        21 => :fade_in,      # 1048576
        22 => :random,       # 2097152
        23 => :last_mod,     # 4194304
        24 => :key9,         # 16777216
        25 => :key10,        # 33554432
        26 => :key1,         # 67108864
        27 => :key3,         # 134217728
        28 => :key2,         # 268435456
      }

      # Convert bits from the API into a readable
      # list of the mods applied.
      def mods(bits : Int32, stringify = false)
        return stringify ? ["None"] : [:none] if bits == 0

        flags = [] of Symbol | String

        MODS.each do |position, flag|
          flags << flag if ((bits >> position) & 0x1) == 1
        end

        flags.map! { |s| s.to_s.split("_").map(&.capitalize).join(" ") } if stringify

        flags
      end

      # Convert an array of symbols into bits to be used
      # in filtering API results in a request
      def bits(mods_list : Array(Symbol))
        value = 0

        MODS.each do |position, flag|
          value += 2**position if mods_list.includes? flag
        end

        value
      end
    end
  end
end
