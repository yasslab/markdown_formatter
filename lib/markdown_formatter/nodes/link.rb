module MarkdownFormatter
  module ASTNode
    class Link < Base
      def to_s
        node.dig(:options, :raw_text).gsub(/\]\(\s*/, "](").gsub(/\R/, " ")
      end
    end
  end
end