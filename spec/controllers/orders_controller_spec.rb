require 'rails_helper'

describe OrdersController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
    @product = FactoryBot.create(:product)
  end

  describe "GET #index" do
    context "when a user is logged in" do
      before do
        sign_in @user
      end

      it "shows the orders index" do
        get :index
        expect(response).to render_template('index')
      end
    end

    context "when a user is not logged in" do
      it "redirects to the login page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #show for some order" do
    let(:order) { Order.create!(user: @user, product: @product) }
    context "when the user is logged in, to whom it belongs" do
      before do
        sign_in @user
      end

      it "shows this order" do
        get :show, params: {id: order.id}
        expect(assigns(:order)).to eq order
        expect(response).to render_template('show')
      end
    end

    context "when a different user is logged in" do
      before do
        sign_in @other_user
      end

      it "redirects to the root page" do
        get :show, params: {id: order.id}
        expect(response).to redirect_to(root_path)
      end
    end

    context "when a user is not logged in" do
      it 'redirects to login' do
        get :show, params: {id: order.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
