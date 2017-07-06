module MarkdownFormatter
  module ASTNode
    class SmartQuote < Base
      def to_s
        case node[:value]
          when /rsquo|lsquo/
            ?'
          when /rdquo|ldquo/
            ?"
        end
      end
    end
  end
end