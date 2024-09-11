class Question < ApplicationRecord
  belongs_to :user
  has_many :responses, dependent: :destroy

  def self.index_page
    find_by_sql(self.response_counts)
  end
  def self.response_counts
    <<SQL
      WITH rc AS (select question_id, count(case when answer = 0 then answer end) as no_count,
             count(case when answer = 1 then answer end) as yes_count
      FROM responses
      GROUP BY question_id)

      SELECT q.id, q.question, q.user_id, u.username, rc.no_count, rc.yes_count
          FROM questions q LEFT JOIN rc on q.id = rc.question_id
          LEFT JOIN users u on q.user_id = u.id;
SQL
  end
end
