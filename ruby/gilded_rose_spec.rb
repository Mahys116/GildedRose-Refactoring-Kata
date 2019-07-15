SimpleCov.start if require 'simplecov'
require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq 'foo'
    end

    context 'default item' do
      it 'quality and sell_in decrease' do
        items = [Item.new('foo', 10, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq 'foo, 9, 9'
      end

      it 'quality degrades by 2 if sell_in < 0' do
        items = [Item.new('foo', 0, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 8
      end

      it 'quality is never negative' do
        items = [Item.new('foo', 10, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end

    context 'Aged Brie' do
      it 'sell_in decrease' do
        items = [Item.new('Aged Brie', 10, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 9
      end

      it 'quality max is 50' do
        items = [Item.new('Aged Brie', 10, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end

      it 'quality increase by 1' do
        items = [Item.new('Aged Brie', 20, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 21
      end

      it 'quality increase by 2 if sell_in < 0' do
        items = [Item.new('Aged Brie', 0, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 22
      end
    end

    context 'Backstage passes to a TAFKAL80ETC concert' do
      it 'sell_in decrease' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 9
      end

      it 'quality increase by 1 if sell_in > 10' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 14, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 21
      end

      it 'quality increase by 2 if sell_in > 5' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 7, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 22
      end

      it 'quality increase by 3 if sell_in <= 5' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 3, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 23
      end

      it 'quality is 0 if sell_in < 0' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      it 'quality increase by 1 if sell_in is 11' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 11, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 21
      end

      it 'quality increase by 2 if sell_in is 10' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 22
      end

      it 'quality increase by 2 if sell_in is 9' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 9, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 22
      end

      it 'quality increase by 2 if sell_in is 6' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 6, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 22
      end

      it 'quality increase by 3 if sell_in is 5' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 23
      end

      it 'quality increase by 3 if sell_in is 4' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 4, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 23
      end


    end

    context 'Sulfuras, Hand of Ragnaros' do
      it 'sell_in does not change' do
        items = [Item.new('Sulfuras, Hand of Ragnaros', 0, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 0
      end

      it 'quality does not change' do
        items = [Item.new('Sulfuras, Hand of Ragnaros', 0, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 80
      end
    end

    context 'Conjured Mana Cake' do
      it 'sell_in decrease' do
        items = [Item.new('Conjured Mana Cake', 10, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 9
      end

      it 'quality decrease by 2' do
        items = [Item.new('Conjured Mana Cake', 10, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 8
      end

      it 'quality decrease by 4 after sell date' do
        items = [Item.new('Conjured Mana Cake', 0, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 6
      end
    end
  end

end
