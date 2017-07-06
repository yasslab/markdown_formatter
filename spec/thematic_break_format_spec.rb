RSpec.describe MarkdownFormatter do
  describe "Thematic breaks" do
    it "simple example" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        ***
        ---
        ___
      TEXT
        ***
        ---
        ___
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "three spaces indent are allowed" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        ---
         ---
          ---
           ---
      TEXT
        ---
         ---
          ---
           ---
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "thematic break with header" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        * hoge

        foo
        ---
      TEXT
        * hoge

        foo
        ---
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end
  end
end