require 'rails_helper'

describe UsersController, type: :controller do
  let(:user1) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  describe 'GET #show for some user' do
    context "when this user is logged in" do
      before do
        sign_in user1
      end

      it 'loads correct user details' do
        get :show, params: {id: user1.id }
        expect(assigns(:user)).to eq user1
        expect(response).to render_template('show')
      end
    end

    context "when a different user is logged in" do
      before do
        sign_in other_user
      end

      it 'redirects to the root page' do
        get :show, params: {id: user1.id }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context "when a user is not logged in" do
      it 'redirects to login' do
        get :show, params: {id: user1.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
