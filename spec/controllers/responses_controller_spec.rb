RSpec.describe ResponsesController, type: :controller do
  let!(:question) { create(:question) }
  let(:do_call) { post :create, params: { response: { answer: :yes, question_id: question.id } }, as: :turbo_stream }

  describe 'POST #create' do
    context 'when user does not exist' do
      let(:unsaved_user) { build(:user) }

      before :each do
        allow(subject).to receive(:current_user).and_return(unsaved_user)
      end

      it 'does not add a record to responses table' do
        expect { do_call }.not_to change { Response.count }
      end

      it 'does not sends a turbo stream response' do
        do_call
        expect(response.body).to be_empty
      end
    end

    context 'when user does exist' do
      render_views
      let(:user) { create(:user) }

      before :each do
        allow(subject).to receive(:current_user).and_return(user)
      end

      it 'adds a record to responses table' do
        expect { do_call }.to change { Response.count }.by(1)
      end

      it 'sends a turbo stream response' do
        do_call
        expect(response.body).to include('<turbo-stream action="replace"')
      end
    end
  end

  describe 'PATCH #update' do
    let!(:question) { create(:question) }
    let!(:response) { create(:response, question: question, answer: :no) }
    let(:do_call) { patch :update, params: { id: response.id, response: { answer: :yes, question_id: question.id } }, as: :turbo_stream }
    let(:user) { create(:user) }

    before :each do
      allow(subject).to receive(:current_user).and_return(user)
    end

    context 'when response saved' do

      it 'changes the value of answer to yes' do
        expect do
          do_call
          response.reload
        end.to change(response, :answer).from('no').to('yes')
      end
    end
  end
end

