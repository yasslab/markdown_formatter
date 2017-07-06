module MarkdownFormatter
  module ASTNode
    class ContainerBlock < Base
      def to_s
        str = ""

        case node[:type]
          when :blockquote
            str += ASTNode::BlockQuote.new(node).to_s
          when :ul, :ol
            str += ASTNode::List.new(node).to_s
          when :table
            # TODO: implements Table node.
          else
            pp node
            raise "Unexpected type #{node[:type]}"
        end

        str
      end
    end
  end
end
