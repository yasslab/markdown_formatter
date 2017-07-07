RSpec.describe MarkdownFormatter do
  describe "BlockQuote" do
    it "simple pattern" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        > hoge
        > piyo
      TEXT
        > hoge piyo
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "paragraph with header" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        > # Foo
        > bar
        > baz

        > ## Foo
        > bar
        > baz

        > Foo
        > ===
        > bar
        > baz
      TEXT
        > # Foo
        > bar baz

        > ## Foo
        > bar baz

        > Foo
        > ===
        > bar baz
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "with list" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        > * fizz
        > * buzz
            fuga
      TEXT
        > * fizz
        > * buzz fuga
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "empty block quote" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        >

        >
        >
        >
      TEXT
        >

        >
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "blank line separate block quotes" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        > foo

        > bar
      TEXT
        > foo

        > bar
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "blank line separate block quotes" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        > > > foo
      TEXT
        > > > foo
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    # FIXME: kramdown parser bag
    xit "ignore block quote ends after the first line" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        > - foo
        - bar
      TEXT
        > - foo
        - bar
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end
  end
end
