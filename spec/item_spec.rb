describe Item do
  let(:item) { Item.new("foo", 1, 2) }

  describe "initialization" do
    it "with a name" do
      expect(item.name).to eq "foo"
    end
    it "with a sell_in" do
      expect(item.sell_in).to eq(1)
    end
    it "with a quality" do
      expect(item.quality).to eq(2)
    end
  end
  describe "#to_s" do
    it "returns a string description of the item" do
      expect(item.to_s).to eq "foo, 1, 2"
    end
  end
end
