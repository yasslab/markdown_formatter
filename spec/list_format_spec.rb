RSpec.describe MarkdownFormatter do
  describe "List Items" do
    describe "Unordered list" do
      it "list item with newline" do
        text, expect =<<~'TEXT', <<~'EXPECT'
          * hoge
          * piyo
            fuga
        TEXT
          * hoge
          * piyo fuga
        EXPECT

        expect(MarkdownFormatter.format(text)).to eq(expect)
      end

      it "multiple list item with newline" do
        text, expect =<<~'TEXT', <<~'EXPECT'
          1. hoge

          2. piyo
             fuga
        TEXT
          1. hoge

          2. piyo fuga
        EXPECT

        expect(MarkdownFormatter.format(text)).to eq(expect)
      end

      it "nested list item" do
        text, expect =<<~'TEXT', <<~'EXPECT'
          * foo
            * bar
              * baz
        TEXT
          * foo
            * bar
              * baz
        EXPECT

        expect(MarkdownFormatter.format(text)).to eq(expect)
      end

      it "multiple list item with codeblock" do
        text, expect =<<~'TEXT', <<~'EXPECT'
          * hoge

                foo

          * piyo

                bar
            baz
        TEXT
          * hoge

                foo

          * piyo

                bar
            baz
        EXPECT

        expect(MarkdownFormatter.format(text)).to eq(expect)
      end

      it "list item with multiline codeblock" do
        text, expect =<<~'TEXT', <<~'EXPECT'
          * sample

              ```ruby
              puts "hello world"


              a = 1 + 1
              ```
        TEXT
          * sample

              ```ruby
              puts "hello world"


              a = 1 + 1
              ```
        EXPECT

        expect(MarkdownFormatter.format(text)).to eq(expect)
      end
    end

    describe "Ordered list" do
      it "list item with newline" do
        text, expect =<<~'TEXT', <<~'EXPECT'
          1. hoge
          2. piyo
             fuga
          3. foo
             bar
             baz
        TEXT
          1. hoge
          2. piyo fuga
          3. foo bar baz
        EXPECT

        expect(MarkdownFormatter.format(text)).to eq(expect)
      end
    end
  end
end