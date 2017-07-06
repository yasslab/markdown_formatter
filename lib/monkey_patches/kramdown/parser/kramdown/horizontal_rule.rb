module Kramdown
  module Parser
    class Kramdown

      # Parse the horizontal rule at the current location.
      def parse_horizontal_rule
        start_line_number = @src.current_line_number
        @src.pos += @src.matched_size
        @tree.children << new_block_el(:hr, nil, nil, :location => start_line_number, raw_text: @src[0].dup)
        true
      end
    end
  end
end