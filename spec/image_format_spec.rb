RSpec.describe MarkdownFormatter do
  describe "Image" do
    it "simple image" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        ![my photo](images/sea.png)
      TEXT
        ![my photo](images/sea.png)
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "url separate" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        ![my photo](
        /url)
      TEXT
        ![my photo](/url)
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "link with title" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        ![foo](/url "title")
      TEXT
        ![foo](/url "title")
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "link with footnote" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        ![foo *bar*]

        [foo *bar*]: train.jpg "train & tracks"
      TEXT
        ![foo *bar*]

        [foo *bar*]: train.jpg "train & tracks"
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "reference style" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        ![foo][bar]

        [bar]: /url
      TEXT
        ![foo][bar]

        [bar]: /url
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end
  end
end