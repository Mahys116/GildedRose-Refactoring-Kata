# frozen_string_literal: true

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item = case item.name
             when 'Aged Brie' then                                 update_aged_brie(item)
             when 'Backstage passes to a TAFKAL80ETC concert' then update_backstage_passes(item)
             when 'Sulfuras, Hand of Ragnaros' then                update_sulfuras(item)
             when 'Conjured Mana Cake' then                        update_conjured(item)
             else update_item(item)
      end
    end
  end

  private

  def update_aged_brie(item)
    item.sell_in -= 1
    item.quality += 1
    item.quality += 1 if item.sell_in < 0
    item.quality = 50 if item.quality > 50
    item
  end

  def update_backstage_passes(item)
    item.sell_in -= 1
    if item.sell_in >= 0
      item.quality += 1
      item.quality += 1 if item.sell_in < 10
      item.quality += 1 if item.sell_in < 5
      item.quality = 50 if item.quality > 50
    else
      item.quality = 0
    end
    item
  end

  def update_sulfuras(item)
    item
  end

  def update_conjured(item)
    item.sell_in -= 1
    item.quality -= 2
    item.quality -= 2 if item.sell_in < 0
    item.quality = 0 if item.quality < 0
    item
  end

  def update_item(item)
    item.sell_in -= 1
    item.quality -= 1
    item.quality -= 1 if item.sell_in < 0
    item.quality = 0 if item.quality < 0
    item
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
