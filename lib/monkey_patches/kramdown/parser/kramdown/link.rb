module Kramdown
  module Parser
    class Kramdown
      # This helper methods adds the approriate attributes to the element +el+ of type +a+ or +img+
      # and the element itself to the @tree.
      def add_link(el, href, title, alt_text = nil, ial = nil, link_id = nil)
        el.options[:ial] = ial
        el.options[:link_id] = link_id

        update_attr_with_ial(el.attr, ial) if ial
        if el.type == :a
          el.attr['href'] = href
          el.options[:link_text] = alt_text
        else
          el.attr['src'] = href
          el.attr['alt'] = alt_text
          el.children.clear
        end
        el.attr['title'] = title if title
        @tree.children << el
      end

      def parse_link
        start_line_number = @src.current_line_number
        result = @src.scan(LINK_START)
        raw_text = result.dup
        cur_pos = @src.pos
        saved_pos = @src.save_pos

        link_type = (result =~ /^!/ ? :img : :a)

        # no nested links allowed
        if link_type == :a && (@tree.type == :img || @tree.type == :a || @stack.any? { |t, s| t && (t.type == :img || t.type == :a) })
          add_text(result)
          return
        end
        el = Element.new(link_type, nil, nil, :location => start_line_number)

        count = 1
        found = parse_spans(el, LINK_BRACKET_STOP_RE) do
          count = count + (@src[1] ? -1 : 1)
          count - el.children.select { |c| c.type == :img }.size == 0
        end
        unless found
          @src.revert_pos(saved_pos)
          add_text(result)
          return
        end
        alt_text = extract_string(cur_pos...@src.pos, @src).gsub(ESCAPED_CHARS, '\1')
        raw_text << alt_text.dup
        @src.scan(LINK_BRACKET_STOP_RE)
        raw_text << @src[0].dup

        # reference style link or no link url
        if @src.scan(LINK_INLINE_ID_RE) || !@src.check(/\(/)
          link_id = normalize_link_id(@src[1] || alt_text)
          if @link_defs.has_key?(link_id)
            add_link(el, @link_defs[link_id][0], @link_defs[link_id][1], alt_text,
                     @link_defs[link_id][2] && @link_defs[link_id][2].options[:ial], link_id)
          else
            warning("No link definition for link ID '#{link_id}' found on line #{start_line_number}")
            @src.revert_pos(saved_pos)
            add_text(result)
          end
          raw_text << @src[0].dup unless @src[0].nil?
          el.options[:raw_text] = raw_text
          return
        end

        # link url in parentheses
        if @src.scan(/\(<(.*?)>/)
          link_url = @src[1]
          if @src.scan(/\)/)
            raw_text += "(<#{link_url}>)"
            el.options[:raw_text] = raw_text
            add_link(el, link_url, nil, alt_text)
            return
          end
        else
          link_url = ''
          nr_of_brackets = 0
          while temp = @src.scan_until(LINK_PAREN_STOP_RE)
            link_url << temp
            if @src[2]
              nr_of_brackets -= 1
              break if nr_of_brackets == 0
            elsif @src[1]
              nr_of_brackets += 1
            else
              break
            end
          end
          raw_text << link_url.dup

          link_url = link_url[1..-2]
          link_url.strip!

          if nr_of_brackets == 0
            el.options[:raw_text] = raw_text
            add_link(el, link_url, nil, alt_text)
            return
          end
        end

        if @src.scan(LINK_INLINE_TITLE_RE)
          raw_text << @src[0].dup
          el.options[:raw_text] = raw_text
          add_link(el, link_url, @src[0][0..-2], alt_text)
        else
          @src.revert_pos(saved_pos)
          add_text(result)
        end
      end
    end
  end
end
