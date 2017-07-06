module MarkdownFormatter
  module ASTNode
    class HTMLElement < Base
      def to_s
        "%s%s</%s>" % [node.dig(:options, :opening_tag), Paragraph.new(node).to_s, node[:value]]
      end
    end
  end
end
