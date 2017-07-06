RSpec.describe MarkdownFormatter do
  describe "Code Block" do
    it "simple code block" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        ```
        puts "Hello World!!"
        ```

            puts "hello world!"
      TEXT
        ```
        puts "Hello World!!"
        ```

            puts "hello world!"
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "multiline code block" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        ```
        puts "one"
        puts "two"
        puts "three"
        ```

            puts "one"
            puts "two"
            puts "three"
      TEXT
        ```
        puts "one"
        puts "two"
        puts "three"
        ```

            puts "one"
            puts "two"
            puts "three"
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end
  end
end