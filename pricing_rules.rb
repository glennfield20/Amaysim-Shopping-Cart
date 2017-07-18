class PricingRules
  
  attr_reader :free_1gb_data_pack, :purchased_items, :promo_code
  
  def add_items(items, promo_code = '')
    @purchased_items = items
    @promo_code = promo_code
  end
  
  def get_all_items
    ult_medium_count = find_sims('ult_medium').count
    ult_medium_count ? bundle_free_1gb_data_pack(ult_medium_count) : purchased_items
  end
  
  def compute_total_price
    total = (
      for_3_unlimited_1gb_sim +
      for_more_than_3_unlimited_5gb_sim +
      for_other_items
    ).round(2)
    
    promo_code == 'I<3AMAYSIM' ? apply_10_percent_discount(total) : total
  end
  
  private
  
  def for_3_unlimited_1gb_sim
    ult_small_items = find_sims('ult_small')
    default_price = ult_small_items.first.price
    total_count = ult_small_items.count
    
    if total_count >= 3
      number_of_items_to_pay = (total_count - (total_count / 3)) + total_count % 3
      default_price * number_of_items_to_pay
    else
      get_the_sum(ult_small_items)
    end
  end
  
  def for_more_than_3_unlimited_5gb_sim
    ult_large_items = find_sims('ult_large')
    
    if ult_large_items.count > 3
      ult_large_items.map! {|item| item.price = 39.90 }.inject(:+)
    else
      get_the_sum(ult_large_items) 
    end
  end
  
  def for_other_items
    other_items = purchased_items.find_all { |item| item.code != 'ult_small' && item.code != 'ult_large' }
    get_the_sum(other_items)
  end
  
  def bundle_free_1gb_data_pack(number)
    @free_1gb_data_pack = []
    number.times do
      @free_1gb_data_pack << Product.new(code: '1gb', name: '1 GB Data-pack', price: 0.0 )
    end
    purchased_items + @free_1gb_data_pack
  end
  
  def apply_10_percent_discount(total)
    (total - ((total * 10) / 100)).round(2)
  end
  
  def find_sims(code)
    purchased_items.find_all { |item| item.code == code }
  end
  
  def get_the_sum(items)
    items.inject(0) {|sum, item| sum + item.price }
  end
end