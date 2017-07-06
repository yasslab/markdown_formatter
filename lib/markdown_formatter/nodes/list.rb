module MarkdownFormatter
  module ASTNode
    class List < Base
      def initialize(node, nest_level = 0)
        super(node)
        @nest_level = nest_level
      end

      def to_s
        node[:children].map do |c|
          case c[:type]
            when :blank
              ""
            when :li
              ListItem.new(c, @nest_level).to_s
            else
              raise "Unexpected type. #{c[:type]}"
          end
        end.join("\n") + "\n"
      end
    end
  end
end
