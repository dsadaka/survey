FactoryBot.define do
  factory :response do
    answer { :yes }
    question { create(:question) }
    user { question.user }
  end
end
