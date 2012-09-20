FactoryGirl.define do
  factory :locale do
    name { Forgery(:basic).text }
  end
end
