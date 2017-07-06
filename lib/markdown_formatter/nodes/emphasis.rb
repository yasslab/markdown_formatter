module MarkdownFormatter
  module ASTNode
    class Emphasis < Base
      def to_s
        delim = node.dig(:options, :delim)
        "%s%s%s" % [delim, Paragraph.new(node).to_s, delim]
      end
    end
  end
end