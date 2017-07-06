module MarkdownFormatter
  module ASTNode
    class Blank < Base
      def to_s
        node[:value]
      end
    end
  end
end
