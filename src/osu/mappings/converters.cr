module Osu
  # :nodoc:
  macro offset_enum_converter(kind, offset)
    struct {{kind.id}}Converter
      def self.from_json(parser)
        index = Int32.new parser.read_string

        API::{{kind.id}}.new index + {{offset}}
      end
    end
  end

  offset_enum_converter Mode, 0
  offset_enum_converter Approval, 2

  # :nodoc:
  struct TagsConverter
    def self.from_json(parser)
      parser.read_string.split " "
    end
  end
end
