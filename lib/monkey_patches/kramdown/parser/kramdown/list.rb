module Kramdown
  module Parser
    class Kramdown
      def parse_list
        start_line_number = @src.current_line_number
        type, list_start_re = (@src.check(LIST_START_UL) ? [:ul, LIST_START_UL] : [:ol, LIST_START_OL])
        list = new_block_el(type, nil, nil, :location => start_line_number, :raw_text => "")

        item = nil
        content_re, lazy_re, indent_re = nil
        eob_found = false
        nested_list_found = false
        last_is_blank = false
        while !@src.eos?
          start_line_number = @src.current_line_number
          if last_is_blank && @src.check(HR_START)
            break
          elsif @src.scan(EOB_MARKER)
            eob_found = true
            break
          elsif @src.scan(list_start_re)
            item = Element.new(:li, nil, nil, :location => start_line_number, :raw_text => @src[0])
            list.options[:raw_text] += @src[0]
            item.value, indentation, content_re, lazy_re, indent_re = parse_first_list_line(@src[1].length, @src[2])
            list.children << item

            item.value.sub!(self.class::LIST_ITEM_IAL) do |match|
              parse_attribute_list($1, item.options[:ial] ||= {})
              ''
            end

            list_start_re = (type == :ul ? /^( {0,#{[3, indentation - 1].min}}[+*-])([\t| ].*?\n)/ :
                               /^( {0,#{[3, indentation - 1].min}}\d+\.)([\t| ].*?\n)/)
            nested_list_found = (item.value =~ LIST_START)
            last_is_blank = false
            item.value = [item.value]
          elsif (result = @src.scan(content_re)) || (!last_is_blank && (result = @src.scan(lazy_re)))
            result.sub!(/^(\t+)/) { " " * 4 * $1.length }
            indentation_found = result.sub!(indent_re, '')
            if !nested_list_found && indentation_found && result =~ LIST_START
              item.value << ''
              nested_list_found = true
            elsif nested_list_found && !indentation_found && result =~ LIST_START
              result = " " * (indentation + 4) << result
            end
            item.options[:raw_text] += @src[0]
            list.options[:raw_text] += @src[0]
            item.value.last << result
            last_is_blank = false
          elsif result = @src.scan(BLANK_LINE)
            nested_list_found = true
            last_is_blank = true
            list.options[:raw_text] += @src.matched

            if list.children.last.type != :blank
              bl = new_block_el(:blank, [@src.matched.dup])
              bl.options[:raw_text] = @src.matched.dup
              list.children << bl
            end

            item.value.last << result
          else
            break
          end
        end

        list.options[:raw_text].gsub!(/\R{2}\z/, "\n")
        list.children.pop if list.children.last.type == :blank
        @tree.children << list

        last = nil
        list.children.each do |it|
          temp = Element.new(:temp, nil, nil, :location => it.options[:location])

          env = save_env
          location = it.options[:location]
          it.value.each do |val|
            @src = ::Kramdown::Utils::StringScanner.new(val, location)
            parse_blocks(temp)
            location = @src.current_line_number
          end
          restore_env(env)

          it.children = temp.children
          it.value = nil
          next if it.children.size == 0

          # Handle the case where an EOB marker is inserted by a block IAL for the first paragraph
          it.children.delete_at(1) if it.children.first.type == :p &&
            it.children.length >= 2 && it.children[1].type == :eob && it.children.first.options[:ial]

          if it.children.first.type == :p &&
            (it.children.length < 2 || it.children[1].type != :blank ||
              (it == list.children.last && it.children.length == 2 && !eob_found)) &&
            (list.children.last != it || list.children.size == 1 ||
              list.children[0..-2].any? { |cit| !cit.children.first || cit.children.first.type != :p || cit.children.first.options[:transparent] })
            it.children.first.children.first.value << "\n" if it.children.size > 1 && it.children[1].type != :blank
            it.children.first.options[:transparent] = true
          end

          if it.children.last.type == :blank
            last = it.children.pop
          else
            last = nil
          end
        end

        @tree.children << last if !last.nil? && !eob_found

        true
      end
    end
  end
end
