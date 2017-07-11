RSpec.describe MarkdownFormatter do
  describe "Links" do
    it "simple link" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        <http://localhost:8080>
      TEXT
        <http://localhost:8080>
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "link with name" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        [`localhost`](http://localhost)
      TEXT
        [`localhost`](http://localhost)
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    # FIXME: Do pass this spec.
    it "link with empty name" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        [link]()

        [link](<>)
      TEXT
        [link]()

        [link](<>)
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "link with newline" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        [`localhost`](
        http://localhost)

        [home
        page](http://localhost)
      TEXT
        [`localhost`](http://localhost)

        [home page](http://localhost)
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "whitespace is allowed around the destination and title" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        [link](   /uri
          "title"  )
      TEXT
        [link](/uri   "title"  )
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "not allowed between the link text and the following parenthesis" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        [link] (/uri)
      TEXT
        [link] (/uri)
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "link with title" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        [`My Page`](http://localhost 'localhost')
      TEXT
        [`My Page`](http://localhost 'localhost')
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "link with image" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        [![My Photo](images/my.png)](http://localhost)
      TEXT
        [![My Photo](images/my.png)](http://localhost)
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "link reference" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        my page is [this][hoge].

        [hoge]:       http://localhost
      TEXT
        my page is [this][hoge].

        [hoge]:       http://localhost
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "example 316" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        [foo](/f&ouml;&ouml; "f&ouml;&ouml;")
      TEXT
        [foo](/f&ouml;&ouml; "f&ouml;&ouml;")
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "example 317" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        [foo]

        [foo]: /f&ouml;&ouml; "f&ouml;&ouml;"
      TEXT
        [foo]

        [foo]: /f&ouml;&ouml; "f&ouml;&ouml;"
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end
  end

  describe "Footnote" do
    it "simple footnote" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        hoge.[^footnote]

        [^footnote]: hello
      TEXT
        hoge.[^footnote]

        [^footnote]: hello
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end
  end
end