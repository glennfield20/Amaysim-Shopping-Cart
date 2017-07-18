class Product
  attr_accessor :code, :name, :price
  
  def initialize(**attributes)
    attributes.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end
end