module Osu
  module API
    module Mode
      extend self

      # NamedTuple of Osu game modes
      Modes = {
        standard: 0,
        taiko:    1,
        ctb:      2,
        mania:    3,
      }

      # Get a game mode ID with a symbol
      def mode(index : Symbol)
        Modes[index]
      end

      # Get a game mode symbold from an ID
      def mode(id : Int32)
        Modes.to_h.key?(id)
      end
    end
  end
end
