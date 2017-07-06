module MarkdownFormatter
  module ASTNode
    class Header < Base
      def to_s
        node.dig(:options, :original_text)
      end
    end
  end
end