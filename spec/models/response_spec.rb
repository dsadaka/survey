
RSpec.describe Response, type: :model do
  describe 'uniqueness on question and user validation' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:question1) { create(:question) }

    before :each do
      response.reload
    end

    context 'when saving a new record with duplicate user and question' do
      let(:response) { create(:response, user: user1, question: question1) }

      it 'is not valid' do
        expect(build(:response, user: user1, question: question1)).to_not be_valid
      end
    end

    context 'when saving a new record with different user and question' do
      let(:response) { create(:response, user: user2, question: question1) }

      it 'is not valid' do
        expect(build(:response, user: user1, question: question1)).to be_valid
      end
    end
  end
end
