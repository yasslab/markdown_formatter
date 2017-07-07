RSpec.describe MarkdownFormatter do
  describe "Header" do
    it "simple headings" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        # foo
        ## foo
        ### foo
        #### foo
        ##### foo
        ###### foo
      TEXT
        # foo
        ## foo
        ### foo
        #### foo
        ##### foo
        ###### foo
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "one line header" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        # hello world
      TEXT
        # hello world
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "header with list" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        * foo
        * bar


        # h1
      TEXT
        * foo
        * bar


        # h1
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    # FIXME: this header pattern unsupported (kramdown)
    xit "under lien header (double text)" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        hello
        world
        ===
      TEXT
        hello world
        ===
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end
  end
end