module MarkdownFormatter
  module ASTNode
    class BlockQuote < Base
      def to_s
        node[:children].map do |c|
          case c[:type]
            when :blank
              ">"
            when :header
              "> " + Header.new(c).to_s.gsub(/\R/, "\n> ")
            when :ol, :ul
              "> " + List.new(c).to_s.gsub(/\R(?!\z)/, "\n> ")
            when :blockquote
              "> " + BlockQuote.new(c).to_s
            else
              "> " + Paragraph.new(c).to_s.gsub(/\R/, " ")
          end
        end.join("\n").chomp + "\n"
      end
    end
  end
end
