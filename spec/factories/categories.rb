FactoryGirl.define do
  factory :category do
    name { Forgery(:basic).text }
    description { Forgery(:basic).text }
  end
end
