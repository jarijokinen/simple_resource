FactoryGirl.define do
  factory :language do
    name { Forgery(:basic).text }
  end
end
