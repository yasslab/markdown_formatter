module Kramdown
  module Parser
    class Kramdown
      # Parse the footnote marker at the current location.
      def parse_footnote_marker
        start_line_number = @src.current_line_number
        @src.pos += @src.matched_size
        fn_def = @footnotes[@src[1]]
        if fn_def
          if fn_def[:eob]
            update_attr_with_ial(fn_def[:eob].attr, fn_def[:eob].options[:ial] || {})
            fn_def[:attr] = fn_def[:eob].attr
            fn_def[:options] = fn_def[:eob].options
            fn_def.delete(:eob)
          end
          fn_def[:marker] ||= []
          fn_def[:marker].push(Element.new(:footnote, fn_def[:content], fn_def[:attr],
                                           fn_def[:options].merge(:name => @src[1], :location => start_line_number, :raw_text => @src[0].dup)))
          @tree.children << fn_def[:marker].last
        else
          warning("Footnote definition for '#{@src[1]}' not found on line #{start_line_number}")
          add_text(@src.matched)
        end
      end
    end
  end
end
