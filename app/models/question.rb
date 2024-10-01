class Question < ApplicationRecord
  belongs_to :user
  has_many :responses, dependent: :destroy

  after_create_commit -> { broadcast_prepend_to "questions", partial: "questions/question", locals: { question: index_row, response: Response.new, current_user_signed_in: true }, target: "questions" }

  def self.index_page
    find_by_sql(self.response_counts)
  end

  def index_row
    @index_row ||= Question.find_by_sql(response_count(id)).first
  end

  def self.response_counts
    <<SQL
      WITH rc AS (select question_id, count(case when answer = 0 then answer end) as no_count,
             count(case when answer = 1 then answer end) as yes_count
      FROM responses
      GROUP BY question_id)

      SELECT q.id, q.question, q.user_id, u.username, rc.no_count, rc.yes_count
          FROM questions q LEFT JOIN rc on q.id = rc.question_id
          LEFT JOIN users u on q.user_id = u.id
          ORDER BY q.created_at DESC;
SQL
  end
  def response_count(qid)
    <<SQL
      WITH rc AS (select question_id, count(case when answer = 0 then answer end) as no_count,
             count(case when answer = 1 then answer end) as yes_count
      FROM responses
      WHERE question_id = #{qid}
      GROUP BY question_id)

      SELECT q.id, q.question, q.user_id, u.username, rc.no_count, rc.yes_count
          FROM questions q LEFT JOIN rc on q.id = rc.question_id
          LEFT JOIN users u on q.user_id = u.id
          WHERE q.id = #{qid}
          ORDER BY q.created_at DESC;
SQL
  end

  def response
    Response.find_by_question_id_and_user_id(id, user_id) || Response.new
  end
end
