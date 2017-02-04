module Osu
  macro int_converter(bit)
    module UInt{{bit}}Converter
      def self.from_json(parser : JSON::PullParser) : UInt{{bit}}
        str = parser.read_string

        str.to_u{{bit}}
      end
    end
  end

  macro float_converter(bit)
    module Float{{bit}}Converter
      def self.from_json(parser : JSON::PullParser) : Float{{bit}}
        str = parser.read_string

        str.to_f{{bit}}
      end
    end
  end

  int_converter 16
  int_converter 32
  int_converter 64

  float_converter 16
  float_converter 32
  float_converter 64
end
