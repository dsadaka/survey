
RSpec.describe Question, type: :model do
  describe 'TurboStream' do
    context 'when new record is saved' do
      let(:question) { build(:question)}

      it 'will fire off an ActionCable blast' do
        expect { question.save }.to broadcast_to('questions')
      end
    end
  end

  describe '#index_page' do
    # Both response1 and response2 are from same user so only first will be saved
    let(:response1) { create(:response, answer: :yes) }
    let(:response2) { create(:response, question: response1.question, answer: :no) }
    let(:response3) { create(:response, question: response1.question, answer: :yes, user: create(:user)) }

    context 'when two valid responses for same question exist' do
      it 'returns correct counts' do
        response1.reload
        result = Question.index_page
        expect(result.count).to eq(1)
        expect(result.first.yes_count).to eq(1)
        expect(result.first.no_count).to eq(0)
      end
    end

    context 'when three valid responses for same question exist' do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      let!(:response1) { create(:response, answer: :yes) }
      let!(:response3) { create(:response, question: response1.question, answer: :yes, user: user1) }
      let!(:response4) { create(:response, question: response1.question, answer: :no, user: user2) }

      it 'returns correct counts' do
        response1.reload
        result = Question.index_page
        expect(result.count).to eq(1)
        expect(result.first.yes_count).to eq(2)
        expect(result.first.no_count).to eq(1)
      end
    end
  end
end
