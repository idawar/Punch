FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    role nil
    trait :client do 
    	role 1
    end
    trait :employee do 
    	role 0
    end
  end
end