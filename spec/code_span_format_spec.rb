RSpec.describe MarkdownFormatter do
  describe "Code Span" do
    it "simple code span" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        `foo`
      TEXT
        `foo`
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "example 322" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        `` foo ` bar  ``
      TEXT
        `` foo ` bar  ``
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "example 322" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        ` `` `
      TEXT
        ` `` `
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "example 324" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        ``
        foo
        ``
      TEXT
        ``foo``
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end
  end
end