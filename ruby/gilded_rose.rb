# frozen_string_literal: true

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items = @items.map { |item| update_item(item) }
  end

  private

  def update_item(item)
    case item.name
    when 'Aged Brie' then                                 AgedBrieUpdater.update(item)
    when 'Backstage passes to a TAFKAL80ETC concert' then BackstagePassesUpdater.update(item)
    when 'Sulfuras, Hand of Ragnaros' then                item
    when 'Conjured Mana Cake' then                        ConjuredItemUpdater.update(item)
    else ItemUpdater.update(item)
    end
  end
end

class BaseItemUpdater
  attr_accessor :item

  def self.update(item)
    new(item).update
  end

  def initialize(item)
    @item = item
  end

  def update
    update_sell_in!
    update_quality!
    @item
  end

  private

  def update_sell_in!
    item.sell_in -= 1
  end

  def update_quality!
    raise NotImplementedError, 'Implement this method in a child class'
  end
end

class ItemUpdater < BaseItemUpdater
  def update_quality!
    item.quality -= 1
    item.quality -= 1 if item.sell_in < 0
    item.quality = 0 if item.quality < 0
  end
end

class AgedBrieUpdater < BaseItemUpdater
  def update_quality!
    item.quality += 1
    item.quality += 1 if item.sell_in < 0
    item.quality = 50 if item.quality > 50
  end
end

class BackstagePassesUpdater < BaseItemUpdater
  def update_quality!
    if item.sell_in >= 0
      item.quality += 1
      item.quality += 1 if item.sell_in < 10
      item.quality += 1 if item.sell_in < 5
      item.quality = 50 if item.quality > 50
    else
      item.quality = 0
    end
  end
end

class ConjuredItemUpdater < BaseItemUpdater
  def update_quality!
    item.quality -= 2
    item.quality -= 2 if item.sell_in < 0
    item.quality = 0 if item.quality < 0
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
