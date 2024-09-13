RSpec.describe QuestionsController, type: :controller do
  let(:question1) { create(:question) }

  describe 'GET #index' do
    let(:do_call) { get :index }

    before do
      question1.reload
      do_call
    end

    context 'without render views' do
      it 'assigns @questions to array of question records' do
        questions = assigns(:questions)
        expect(questions.first.question).to eq(question1.question)
        # expect(assigns(:question).id).to be_nil
      end
    end

    context 'with render_views' do
      render_views

      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end

      it "has a heading starting with Surveys" do
        get :index
        expect(response.body).to match /<h2 .*Surveys/im
      end
    end
  end

  describe 'POST #create' do
    let(:question1_question) { question }

    context 'when user does not exist' do
      let(:question) { question1.question }
      let(:do_call) { post :create, params: { question: { question: question } } }
      let(:unsaved_user) { build(:user) }

      before :each do
        allow(subject).to receive(:current_user).and_return(unsaved_user)
      end

      it 'does not add a record to questions table' do
        question1.reload
        expect { do_call }.not_to change { Question.count }
      end
    end

    context 'when user does exist' do
      render_views

      let(:question) { build(:question) }
      let(:do_call) { post :create, params: { question: { question: question } } }

      before :each do
        question1.reload
      end

      it 'adds a record to questions table' do
        question1.reload
        expect { do_call }.not_to change { Question.count }
      end
    end
  end
end
