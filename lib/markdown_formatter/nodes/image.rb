module MarkdownFormatter
  module ASTNode
    class Image < Base
      def to_s
        node.dig(:options, :raw_text).gsub(/\R/, '')
      end
    end
  end
end