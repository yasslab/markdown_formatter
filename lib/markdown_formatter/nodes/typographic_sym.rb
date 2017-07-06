module MarkdownFormatter
  module ASTNode
    class TypographicSym < Base
      def to_s
        node.dig(:options, :symbol)
      end
    end
  end
end
