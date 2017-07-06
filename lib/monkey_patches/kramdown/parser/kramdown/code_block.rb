module Kramdown
  module Parser
    class Kramdown

      # Parse the indented codeblock at the current location.
      def parse_codeblock
        start_line_number = @src.current_line_number
        data = @src.scan(self.class::CODEBLOCK_MATCH)
        data.gsub!(/\n( {0,3}\S)/, ' \\1')
        data.gsub!(INDENT, '')
        @tree.children << new_block_el(:codeblock, data, nil, :location => start_line_number, :raw_text => @src.matched.dup)
        true
      end

      # Parse the fenced codeblock at the current location.
      def parse_codeblock_fenced
        if @src.check(self.class::FENCED_CODEBLOCK_MATCH)
          start_line_number = @src.current_line_number
          @src.pos += @src.matched_size
          el = new_block_el(:codeblock, @src[5], nil, :location => start_line_number, :raw_text => @src.matched.dup)
          lang = @src[3].to_s.strip
          unless lang.empty?
            el.options[:lang] = lang
            el.attr['class'] = "language-#{@src[4]}"
          end
          @tree.children << el
          true
        else
          false
        end
      end
    end
  end
end
