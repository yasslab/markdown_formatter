RSpec.describe MarkdownFormatter do
  describe "Table" do
    it "simple table" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        | foo | bar |
        | --- | --- |
        | baz | bim |
      TEXT
        | foo | bar |
        | --- | --- |
        | baz | bim |
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end
  end
end