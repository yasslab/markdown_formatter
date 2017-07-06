module Kramdown
  module Parser
    class Kramdown

      # Parse the paragraph at the current location.
      def parse_paragraph
        start_line_number = @src.current_line_number
        result = @src.scan(PARAGRAPH_MATCH)
        while !@src.match?(paragraph_end)
          result << @src.scan(PARAGRAPH_MATCH)
        end
        raw_text = result.dup
        result.rstrip!
        if @tree.children.last && @tree.children.last.type == :p
          @tree.children.last.children.first.value << "\n" << result
        else
          @tree.children << new_block_el(:p, nil, nil, :location => start_line_number, raw_text: raw_text)
          result.lstrip!
          add_text(result, @tree.children.last)
        end
        true
      end
    end
  end
end