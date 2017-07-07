module MarkdownFormatter
  module ASTNode
    class CodeBlock < Base
      def to_s
        node.dig(:options, :raw_text).chomp.strip_heredoc
      end
    end
  end
end
