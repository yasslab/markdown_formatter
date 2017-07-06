module Kramdown
  module Parser
    class Kramdown

      # Parse the blockquote at the current location.
      def parse_blockquote
        start_line_number = @src.current_line_number
        result = @src.scan(PARAGRAPH_MATCH)
        while !@src.match?(self.class::LAZY_END)
          result << @src.scan(PARAGRAPH_MATCH)
        end
        raw_text = result.dup
        result.gsub!(BLOCKQUOTE_START, '')

        el = new_block_el(:blockquote, nil, nil, :location => start_line_number, :raw_text => raw_text)
        @tree.children << el
        parse_blocks(el, result)
        true
      end
    end
  end
end
