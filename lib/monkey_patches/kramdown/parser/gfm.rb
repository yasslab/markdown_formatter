module Kramdown
  module Parser
    class GFM < Kramdown::Parser::Kramdown

      # Copied from kramdown/parser/kramdown/header.rb, removed the first line
      def parse_atx_header_gfm_quirk
        start_line_number = @src.current_line_number
        @src.check(ATX_HEADER_MATCH)
        level, text, id = @src[1], @src[2].to_s.strip, @src[3]
        return false if text.empty?

        @src.pos += @src.matched_size
        el = new_block_el(:header, nil, nil, :level => level.length, :raw_text => text, :location => start_line_number, :original_text => @src[0].chomp)
        add_text(text, el)
        el.attr['id'] = id if id
        @tree.children << el
        true
      end
    end
  end
end
