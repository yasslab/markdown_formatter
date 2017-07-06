module MarkdownFormatter
  module ASTNode
    class Entity < Base
      def to_s
        node.dig(:options, :original)
      end
    end
  end
end
