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
  end

end
