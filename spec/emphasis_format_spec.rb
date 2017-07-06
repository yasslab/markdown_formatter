RSpec.describe MarkdownFormatter do
  describe "Emphasis" do
    it "Simple emphasis" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        _hello_
      TEXT
        _hello_
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "Multiple emphasis text" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        _hello_ *world*
      TEXT
        _hello_ *world*
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "Not empahsis pattern" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        a * foo bar*

        a*"foo"*
      TEXT
        a * foo bar*

        a*"foo"*
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end
  end

  describe "Strong" do
    it "simple pattern" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        **hello**
      TEXT
        **hello**
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "multiple strong" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        __hello__ **world**
      TEXT
        __hello__ **world**
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "not strong pattern" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        ** foo bar**

        a**"foo"**
      TEXT
        ** foo bar**

        a**"foo"**
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end
  end
end
