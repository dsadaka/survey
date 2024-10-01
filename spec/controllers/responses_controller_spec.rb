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
    end

    context 'when user does exist' do
      let(:user) { create(:user) }

      before :each do
        allow(subject).to receive(:current_user).and_return(user)
      end

      render_views

      it 'adds a record to responses table' do
        expect { do_call }.to change { Response.count }.by(1)
      end
    end
  end
end
