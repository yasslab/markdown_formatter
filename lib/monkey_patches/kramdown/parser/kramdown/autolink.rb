module Kramdown
  module Parser
    class Kramdown

      # Parse the autolink at the current location.
      def parse_autolink
        start_line_number = @src.current_line_number
        @src.pos += @src.matched_size
        href = (@src[2].nil? ? "mailto:#{@src[1]}" : @src[1])
        el = Element.new(:a, nil, {'href' => href}, :location => start_line_number, :raw_text => @src[0].dup)
        add_text(@src[1].sub(/^mailto:/, ''), el)
        @tree.children << el
      end
    end
  end
end
