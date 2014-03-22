FactoryGirl.define do
  factory :record do
    created_at { Time.now }
    glucose "123"
    weight "100"
  end

  factory :diabetic do
    name CoolFaker::Character.name
    email Faker::Internet.email
  end
end