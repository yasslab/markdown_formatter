module MarkdownFormatter
  module ASTNode
    class ThematicBreak < Base
      def to_s
        node.dig(:options, :raw_text)
      end
    end
  end
end