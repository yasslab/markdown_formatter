module MarkdownFormatter
  module ASTNode
    class Base
      attr_reader :node

      def initialize(node)
        @node = node
      end
    end
  end
end
