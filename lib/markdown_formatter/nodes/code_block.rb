module MarkdownFormatter
  module ASTNode
    class CodeBlock < Base
      def to_s
        node.dig(:options, :raw_text).chomp
      end
    end
  end
end
