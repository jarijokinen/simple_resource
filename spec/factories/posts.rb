FactoryGirl.define do
  factory :post do
    category
    language
    title { Forgery(:basic).text }
    content { Forgery(:basic).text }
  end
end
