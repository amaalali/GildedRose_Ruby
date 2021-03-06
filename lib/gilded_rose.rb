class GildedRose

  SPECIAL_ITEMS = ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Sulfuras, Hand of Ragnaros"]

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if regular_item?(item)
        modify_quality(item)
      else
        if below_max?(item)
          increase_quality_of_specials(item)
          if item.name == "Backstage passes to a TAFKAL80ETC concert" #TODO Backstage passes only
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end

      if item.name != "Sulfuras, Hand of Ragnaros" #TODO update sell in
        item.sell_in = item.sell_in - 1
      end

      if item.sell_in < 0 #TODO WHen zero
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality #TODO Backstage passes to a TAFKAL80ETC concert
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1 #TODO Increases qualiity for Brie
          end
        end
      end

    end
  end

  def modify_quality(item)
    item.quality = item.quality - 1 unless at_minimum_quality?(item)
  end

  def regular_item?(item)
    !SPECIAL_ITEMS.include?(item.name)
  end

  def at_minimum_quality?(item)
    !(item.quality > 0)
  end

  def increase_quality_of_specials(item)
    item.quality = item.quality + 1
  end

  def below_max?(item)
    item.quality < 50
  end
  # def legacy_update_quality()
  #   @items.each do |item|
  #     if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert" #TODO update quality
  #       if item.quality > 0 #TODO Guard, cannot decrese below 0
  #         if item.name != "Sulfuras, Hand of Ragnaros" #TODO Filter, Special items
  #           item.quality = item.quality - 1 #TODO Medthod
  #         end
  #       end
  #     else
  #       if item.quality < 50 #TODO  Brie and Backstage
  #         item.quality = item.quality + 1 #TODO Quality of cheese
  #         if item.name == "Backstage passes to a TAFKAL80ETC concert" #TODO Backstage passes only
  #           if item.sell_in < 11
  #             if item.quality < 50
  #               item.quality = item.quality + 1
  #             end
  #           end
  #           if item.sell_in < 6
  #             if item.quality < 50
  #               item.quality = item.quality + 1
  #             end
  #           end
  #         end
  #       end
  #     end
  #
  #     if item.name != "Sulfuras, Hand of Ragnaros" #TODO update sell in
  #       item.sell_in = item.sell_in - 1
  #     end
  #
  #     if item.sell_in < 0 #TODO WHen zero
  #       if item.name != "Aged Brie"
  #         if item.name != "Backstage passes to a TAFKAL80ETC concert"
  #           if item.quality > 0
  #             if item.name != "Sulfuras, Hand of Ragnaros"
  #               item.quality = item.quality - 1
  #             end
  #           end
  #         else
  #           item.quality = item.quality - item.quality #TODO Backstage passes to a TAFKAL80ETC concert
  #         end
  #       else
  #         if item.quality < 50
  #           item.quality = item.quality + 1 #TODO Increases qualiity for Brie
  #         end
  #       end
  #     end
  #
  #   end
  # end
end
