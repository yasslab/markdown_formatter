module MarkdownFormatter
  class CLI
    def self.run(filepath)
      puts MarkdownFormatter.format(File.read(filepath))
    end
  end
end