module Kramdown
  module Parser
    class Kramdown

      # Parse the backslash-escaped character at the current location.
      def parse_escaped_chars
        @src.pos += @src.matched_size
        add_text(@src[0])
      end
    end
  end
end