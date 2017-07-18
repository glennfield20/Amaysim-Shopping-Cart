class ShoppingCart 
  
  attr_reader :items_added, :pricing_rules, :promo_code
  
  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @items_added = []
  end
  
  def add(item, promo_code = nil)
    items_added << item
    @promo_code ||= promo_code
  end
  
  def total
    pricing_rules.add_items(self.items_added, promo_code)
    pricing_rules.compute_total_price
  end
  
  def items
    pricing_rules.add_items(self.items_added)
    pricing_rules.get_all_items
  end
end
