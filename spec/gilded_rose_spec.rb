# require File.join(File.dirname(__FILE__), '../lib/gilded_rose')

describe GildedRose do
  let(:items)           {[Item.new(name="+5 Dexterity Vest", sell_in=10, quality=20),
                          Item.new(name="Aged Brie", sell_in=2, quality=0),
                          Item.new(name="Elixir of the Mongoose", sell_in=5, quality=7),
                          Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=80),
                          Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=-1, quality=80),
                          Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20),
                          Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=49),
                          Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=5, quality=49) ]}

  let(:updated_items)   {[Item.new(name="+5 Dexterity Vest", sell_in=9, quality=19),
                          Item.new(name="Aged Brie", sell_in=1, quality=1),
                          Item.new(name="Elixir of the Mongoose", sell_in=4, quality=6),
                          Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=80),
                          Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=-1, quality=80),
                          Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=14, quality=21),
                          Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=9, quality=50),
                          Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=4, quality=50) ]}

  let(:gilded_rose)     { GildedRose.new(items) }

  describe "#update_quality" do
    before(:each) do
      gilded_rose.update_quality()
    end

    it "does not change the name" do
      items_name = items.map { |item| item.name }
      updated_items_name = updated_items.map { |item| item.name }
      expect(items_name).to eq(updated_items_name)
    end

    it "decreases quality at the end of the day appropiately" do
      items_quality = items.map { |item| item.quality }
      updated_items_quality = updated_items.map { |item| item.quality }
      expect(items_quality).to eq(updated_items_quality)
    end

    it "decreases the sell_in at the end of the day appropiately" do
      items_sell_in = items.map { |item| item.sell_in }
      updated_items_sell_in = updated_items.map { |item| item.sell_in }
      expect(items_sell_in).to eq(updated_items_sell_in)
    end

    it "updates the information to all items" do
      items_description = items.map { |item| item.to_s }
      updated_items_description = updated_items.map { |item| item.to_s }
      expect(items_description).to eq(updated_items_description)
    end

    it "decrease quality of items twice as fast when out of date" do
      item1 = Item.new("bob", 0, 20)
      items = [item1]
      gilded_rose = GildedRose.new(items)
      gilded_rose.update_quality()
      expect(item1.quality).to eq(18)
    end

    it "should never have a quality less than zero" do
      item1 = Item.new("bob", 2, 0)
      items = [item1]
      gilded_rose = GildedRose.new(items)
      gilded_rose.update_quality()
      expect(item1.quality).to eq(0)
    end
  end
end

describe 'Special Items' do
  let(:item1)       { Item.new(name="Aged Brie", sell_in=2, quality=0) }
  let(:item2)       { Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=80) }
  let(:item3)       { Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=20) }
  let(:items)       { [item1, item2, item3] }
  let(:gilded_rose) { GildedRose.new(items) }

  context 'Special Items' do
    it "Aged Brie increases in quality the older it gets" do
      gilded_rose.update_quality()
      expect(item1.quality).to eq(1)
    end

    it "item quality cannot be increase to greater than 50" do
      51.times { gilded_rose.update_quality() }
      expect(item1.quality).to eq(50)
    end

    it "Sulfuras is never sold and never decreases in quality" do
      gilded_rose.update_quality()
      expect(item2.quality).to eq(80)
      expect(item2.sell_in).to eq(0)
    end

    it "Backstage increase in quality by 2 when 10 days or less" do
      gilded_rose.update_quality()
      expect(item3.quality).to eq(22)
    end

    it "Backstage increase in quality by 3 when 5 days or less" do
      item3.sell_in = 5
      gilded_rose.update_quality()
      expect(item3.quality).to eq(23)
    end

    it "Backstage have quality of 0 when sell_in is 0 days" do
      11.times { gilded_rose.update_quality() }
      expect(item3.quality).to eq(0)
    end
  end
end
