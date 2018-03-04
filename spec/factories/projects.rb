FactoryBot.define do
  factory :project do
    name { Faker::Lorem.word }
    client { User.client.first || create(:user, :client) }
  end
end