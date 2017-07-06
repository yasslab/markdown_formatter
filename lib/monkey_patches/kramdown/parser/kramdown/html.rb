module Kramdown
  module Parser
    class Kramdown
      # Parse the HTML at the current position as span-level HTML.
      def parse_span_html
        line = @src.current_line_number
        if result = @src.scan(HTML_COMMENT_RE)
          @tree.children << Element.new(:xml_comment, result, nil, :category => :span, :location => line)
        elsif result = @src.scan(HTML_INSTRUCTION_RE)
          @tree.children << Element.new(:xml_pi, result, nil, :category => :span, :location => line)
        elsif result = @src.scan(HTML_TAG_CLOSE_RE)
          warning("Found invalidly used HTML closing tag for '#{@src[1]}' on line #{line}")
          add_text(result)
        elsif result = @src.scan(HTML_TAG_RE)
          tag_name = @src[1]
          tag_name.downcase! if HTML_ELEMENT[tag_name.downcase]
          if HTML_BLOCK_ELEMENTS.include?(tag_name)
            warning("Found block HTML tag '#{tag_name}' in span-level text on line #{line}")
            add_text(result)
            return
          end

          attrs = parse_html_attributes(@src[2], line, HTML_ELEMENT[tag_name])
          attrs.each { |name, value| value.gsub!(/\n+/, ' ') }

          do_parsing = (HTML_CONTENT_MODEL[tag_name] == :raw || @tree.options[:content_model] == :raw ? false : @options[:parse_span_html])
          if val = HTML_MARKDOWN_ATTR_MAP[attrs.delete('markdown')]
            if val == :block
              warning("Cannot use block-level parsing in span-level HTML tag (line #{line}) - using default mode")
            elsif val == :span
              do_parsing = true
            elsif val == :default
              do_parsing = HTML_CONTENT_MODEL[tag_name] != :raw
            elsif val == :raw
              do_parsing = false
            end
          end

          el = Element.new(:html_element, tag_name, attrs, :category => :span, :location => line,
                           :content_model => (do_parsing ? :span : :raw), :is_closed => !!@src[4], :opening_tag => result)
          @tree.children << el
          stop_re = /<\/#{Regexp.escape(tag_name)}\s*>/
          stop_re = Regexp.new(stop_re.source, Regexp::IGNORECASE) if HTML_ELEMENT[tag_name]
          if !@src[4] && !HTML_ELEMENTS_WITHOUT_BODY.include?(el.value)
            if parse_spans(el, stop_re, (do_parsing ? nil : [:span_html]))
              @src.scan(stop_re)
            else
              warning("Found no end tag for '#{el.value}' (line #{line}) - auto-closing it")
              add_text(@src.rest, el)
              @src.terminate
            end
          end
          Kramdown::Parser::Html::ElementConverter.convert(@root, el) if @options[:html_to_native]
        else
          add_text(@src.getch)
        end
      end
    end
  end
end
