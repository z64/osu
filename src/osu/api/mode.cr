module Osu
  module API
    module Mode
      extend self

      Modes = {
        standard: 0,
        taiko:    1,
        ctb:      2,
        mania:    3,
      }

      def mode(index)
        Modes[index]
      end
    end
  end
end
