module MarkdownFormatter
  module ASTNode
    class Paragraph < Base
      def to_s
        node[:children].map do |c|
          case c[:type]
            when :a
              Link.new(c).to_s
            when :text
              c[:value]
            when :strong
              Strong.new(c).to_s
            when :codespan
              CodeSpan.new(c).to_s
            when :br
              # skip
            when :em
              Emphasis.new(c).to_s
            when :smart_quote
              SmartQuote.new(c).to_s
            when :typographic_sym
              TypographicSym.new(c).to_s
            when :img
              Image.new(c).to_s
            when :html_element
              HTMLElement.new(c).to_s
            when :entity
              Entity.new(c).to_s
            when :footnote
              Footnote.new(c).to_s
            else
              pp c
              raise "Unexpected type `#{c[:type]}'"
          end
        end.join
      end
    end
  end
end