class Response < ApplicationRecord
  belongs_to :question
  belongs_to :user

  enum :answer, { no: 0, yes: 1 }, prefix: true

end
