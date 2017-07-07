module MarkdownFormatter
  module ASTNode
    class ListItem < Base
      def initialize(node, nest_level = 0)
        super(node)
        @nest_level = nest_level
      end

      def to_s
        /^(?<prefix>\s*([0-9]+\.|[-+*])\s*)/ =~ node.dig(:options, :raw_text)
        indents = node.dig(:options, :raw_text).split(/\R/).map do |line|
          line.match(/^\s+/).to_s
        end

        (" " * @nest_level * 2) + prefix + node[:children].map { |c|
          case c[:type]
            when :p
              indents.shift + Paragraph.new(c).to_s.gsub(/\R/, " ").split.join(" ")
            when :blank
              ""
            when :codeblock
              CodeBlock.new(c).to_s.indent(indents.shift.size)
            when :ul
              List.new(c, @nest_level + 1).to_s.chomp
            else
              raise "Unexpected type #{c[:type]}"
          end
        }.join("\n")
      end
    end
  end
end
