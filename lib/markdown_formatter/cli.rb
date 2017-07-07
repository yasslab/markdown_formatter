module MarkdownFormatter
  class CLI
    def self.run(filepath)
      result = MarkdownFormatter.format(File.read(filepath))

      if MarkdownFormatter::OPTIONS[:overwrite]
        File.write(filepath, result)
      else
        puts result
      end
    end
  end
end
