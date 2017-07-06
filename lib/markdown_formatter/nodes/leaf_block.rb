module MarkdownFormatter
  module ASTNode
    class LeafBlock < Base
      def to_s
        case node[:type]
          when :a
            Link.new(c).to_s
          when :p
            Paragraph.new(c).to_s
          when :strong
            Strong.new(c).to_s
          when :codespan
            CodeSpan.new(c).to_s
          when :em
            Emphasis.new(c).to_s
          when :html_element
            str += HTMLElement.new(c).to_s
          when :footnote
            str += Footnote.new(c).to_s
          else
            pp c
            raise "Unexpected type `#{c[:type]}'"
        end
      end
    end
  end
end