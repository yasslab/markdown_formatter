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

      it "nested list indent 4 space" do
        text, expect =<<~'TEXT', <<~'EXPECT'
          * text
              * foo
        TEXT
          * text
              * foo
        EXPECT

        expect(MarkdownFormatter.format(text)).to eq(expect)
      end

      # FIXME: kramdown parser bug
      xit "[edge case] multiple list item with codeblock" do
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

      it "list item with codeblock with paragraph" do
        text, expect =<<~'TEXT', <<~'EXPECT'
          * sample

              ```ruby
              puts "hello world"
              ```

              sample code

          * bar
        TEXT
          * sample

              ```ruby
              puts "hello world"
              ```

              sample code

          * bar
        EXPECT

        expect(MarkdownFormatter.format(text)).to eq(expect)
      end

      it "list item with multi codeblock" do
        text, expect =<<~'TEXT', <<~'EXPECT'
        * methods

            ```ruby
            def say
              "hello"
            end
            ```

            ..can now be written as

            ```ruby
            def say
              'hello'
            end
            ```
        TEXT
        * methods

            ```ruby
            def say
              "hello"
            end
            ```

            ..can now be written as

            ```ruby
            def say
              'hello'
            end
            ```
        EXPECT

        expect(MarkdownFormatter.format(text)).to eq(expect)
      end

      it "list item with codeblock include breakline" do
        text, expect =<<~'TEXT', <<~'EXPECT'
        * stdout

            ```ruby
            puts "hello"

            puts "world"
            ```

            In the example
        TEXT
        * stdout

            ```ruby
            puts "hello"

            puts "world"
            ```

            In the example
        EXPECT

        expect(MarkdownFormatter.format(text)).to eq(expect)
      end

      it "nested list item with codeblock" do
        text, expect =<<~'TEXT', <<~'EXPECT'
        * foo
          * bar

            ```ruby
            puts "hello"
            ```
        TEXT
        * foo
          * bar

            ```ruby
            puts "hello"
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