FactoryGirl.define do
  factory :product do
    trait :unlimited_one_gb do
      code 'ult_small'
      name 'Unlimited 1GB'
      price 24.90
    end
    
    trait :unlimited_two_gb do
      code 'ult_medium'
      name 'Unlimited 2GB'
      price 29.90
    end
    
    trait :unlimited_five_gb do
      code 'ult_large'
      name 'Unlimited 5GB'
      price 44.90
    end
    
    trait :one_gb_data_pack do
      code '1gb'
      name '1 GB Data-pack'
      price 9.90
    end
  end
end