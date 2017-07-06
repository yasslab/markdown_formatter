RSpec.describe MarkdownFormatter do
  describe "Entity" do
    it "Entity references" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        &nbsp; &amp; &copy; &AElig; &Dcaron;

        &frac34; &HilbertSpace; &DifferentialD;

        &ClockwiseContourIntegral; &ngE;
      TEXT
        &nbsp; &amp; &copy; &AElig; &Dcaron;

        &frac34; &HilbertSpace; &DifferentialD;

        &ClockwiseContourIntegral; &ngE;
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "Decimal numeric character" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        &#35; &#1234; &#992; &#98765432; &#0;
      TEXT
        &#35; &#1234; &#992; &#98765432; &#0;
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end

    it "Hexadecimal numeric character" do
      text, expect =<<~'TEXT', <<~'EXPECT'
        &#X22; &#XD06; &#xcab;
      TEXT
        &#X22; &#XD06; &#xcab;
      EXPECT

      expect(MarkdownFormatter.format(text)).to eq(expect)
    end
  end
end
