module MarkdownFormatter
  module ASTNode
    class Inline < Base
      def to_s
        case node[:type]
          when :a
            Link.new(c).to_s
          when :text
            node[:value]
          when :br
            # skip
          when :smart_quote
            SmartQuote.new(c).to_s
          when :typographic_sym
            TypographicSym.new(c).to_s
          when :img
            Image.new(c).to_s
          when :entity
            Entity.new(c).to_s
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
