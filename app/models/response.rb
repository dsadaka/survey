class Response < ApplicationRecord
  belongs_to :question
  belongs_to :user

  after_create_commit -> { broadcast_replace_to "questions", partial: "questions/yes_pct", locals: { question: question.index_row,  }, target: "yes_question_#{question.id}" }
  after_create_commit -> { broadcast_replace_to "questions", partial: "questions/no_pct", locals: { question: question.index_row,  }, target: "no_question_#{question.id}" }
  after_update_commit -> { broadcast_replace_to "questions", partial: "questions/yes_pct", locals: { question: question.index_row,  }, target: "yes_question_#{question.id}" }
  after_update_commit -> { broadcast_replace_to "questions", partial: "questions/no_pct", locals: { question: question.index_row,  }, target: "no_question_#{question.id}" }

  enum :answer, { no: 0, yes: 1 }, prefix: true

  validates_uniqueness_of :question_id, scope: :user_id
end
