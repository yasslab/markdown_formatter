RSpec.describe MarkdownFormatter do
  describe "Raw HTML" do
    it "link" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        link is
        <a href="#hoge">hoge</a>.
      TEXT
        link is <a href="#hoge">hoge</a>.
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end
  end
end