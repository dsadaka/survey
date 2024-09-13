FactoryBot.define do
  factory :question do
    question { 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ' }
    user { create(:user) }
  end
end
