RSpec.describe MarkdownFormatter do
  describe "Normal Text" do
    it "normal text" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        hello
        world
      TEXT
        hello world
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "multiple newline" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        hello

        world
        test
      TEXT
        hello

        world test
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "escaped character" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        \!\"\#\$\%\&\'\(\)\*\+\,\-\.\/\:\;\<\=\>\?\@\[\\\]\^\_\`\{\|\}\~

        !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
      TEXT
        \!\"\#\$\%\&\'\(\)\*\+\,\-\.\/\:\;\<\=\>\?\@\[\\\]\^\_\`\{\|\}\~

        !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "backtick string is not closed" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        ```foo``
      TEXT
        ```foo``
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "no themantic breaks character" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        --
        **
        __
      TEXT
        -- ** __
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "more than six `#` characters is not a heading" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        ###### foo
      TEXT
        ###### foo
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end
  end

  describe "typographic sym" do
    it "simple typographic" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        from ... to

        from -- to
      TEXT
        from ... to

        from -- to
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end
  end
end
