require 'factory_girl'
require 'pry'
require_relative '../../pricing_rules'
require_relative '../../product'
require_relative '../../shopping_cart'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

# RSpec without Rails
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end