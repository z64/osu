module Osu
  # API time formats
  TIME_FORMAT = Time::Format.new("%F %X")

  module MaybeTimeConverter
    def self.from_json(parser)
      str = parser.read_string_or_null
      return unless str

      TIME_FORMAT.parse(str)
    end
  end

  macro offset_enum_converter(kind, offset)
    # :nodoc:
    module {{kind.id}}Converter
      def self.from_json(parser)
        index = Int32.new parser.read_string

        API::{{kind.id}}.new index + {{offset}}
      end
    end
  end

  offset_enum_converter Mode, 0
  offset_enum_converter Mod, 0
  offset_enum_converter Approval, 2

  # :nodoc:
  module TagsConverter
    def self.from_json(parser)
      parser.read_string.split " "
    end
  end

  # :nodoc:
  module PerfectConverter
    def self.from_json(parser)
      value = parser.read_string

      value == "true" ? true : false
    end
  end
end
