require_relative './support/spec_helper'

describe 'special offers and promotions' do
  
  let!(:pricing_rule) { PricingRules.new }
  let!(:cart) { ShoppingCart.new(pricing_rule) }
  let!(:item1)  { build :product, :unlimited_one_gb }
  let!(:item2)  { build :product, :unlimited_two_gb }
  let!(:item3)  { build :product, :unlimited_five_gb }
  let!(:item4)  { build :product, :one_gb_data_pack }
  
  context 'when 3 unlimited 1gb sims are bought' do
    before do
      3.times { cart.add(item1) }
      cart.add(item3)
    end
    
    it 'only pays the price of 2 sim for the first month' do
      expect(cart.total).to eq 94.70
      expect(cart.items).to eq cart.items_added 
    end
  end
 
  context 'when more than three unlimited 5gb sims are bought' do
    before do
      2.times { cart.add(item1) }
      4.times { cart.add(item3) }
    end
    
    it 'drops the price of each to 39.90 dollars' do
      expect(cart.total).to eq 209.40
      expect(cart.items).to eq cart.items_added
    end
  end
  
  context 'every purchase of Unlimited 2GB' do
    before do
      cart.add(item1)
      2.times { cart.add(item2) }
    end
    
    it 'bundles free 1gb data-pack free of charges' do
      expect(cart.total).to eq 84.70
      expect(cart.items.find_all {|item| item.name == '1 GB Data-pack'}.count).to eq 2
    end
  end
  
  context "when adding the promo code 'I<3AMAYSIM'" do
    before do
      cart.add(item1)
      cart.add(item4, 'I<3AMAYSIM')
    end
    
    it 'applys 10 percent discount across the board' do
      expect(cart.total).to eq 31.32
      expect(cart.items).to eq cart.items_added
    end
  end
end