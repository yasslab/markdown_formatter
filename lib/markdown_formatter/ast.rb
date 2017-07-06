module MarkdownFormatter
  class AST
    def initialize(source)
      @source = source.dup
      doc = Kramdown::Document.new(source.dup, input: "GFM")
      @ast, @warnings = doc.to_hash_ast
      # pp @ast
    end

    def traverse(parent = [@ast])
      parent.each do |node|
        case node[:type]
          when :root
            traverse(node[:children])
          when :blank
            # skip event
          when :p
            str = ASTNode::Paragraph.new(node).to_s

            unless @source.sub!(node.dig(:options, :raw_text).chomp) { |m| str.gsub(/\R(?!\z)/, " ").chomp }
              raise "Parse Failed!!"
            end
          when :ul, :ol, :blockquote
            str = ASTNode::ContainerBlock.new(node).to_s
            unless @source.sub!(node.dig(:options, :raw_text), str)
              raise "Parse Failed!!"
            end
          when :header
            # skip event
          when :hr
            # skip event
          when :codeblock
            # skip event
          when :table
            # TODO: implements Table node.
          else
            pp node
            raise "Unexpected type #{node[:type]}"
        end
      end
    end

    def to_s
      traverse
      @source
    end
  end
end