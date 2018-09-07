require 'rails_helper'

describe OrdersController, type: :controller do
  let(:admin) { FactoryBot.create(:admin) }
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product) }

  describe "GET #index" do
    context "when a user is logged in" do
      before do
        sign_in user
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
  end ### end of "GET #index" ##################################################

  describe "GET #show for some order" do
    let(:order) { Order.create!(user: user, product: product) }
    context "when the user is logged in, to whom it belongs" do
      before do
        sign_in user
      end

      it "shows this order" do
        get :show, params: {id: order.id}
        expect(assigns(:order)).to eq order
        expect(response).to render_template('show')
      end
    end

    context "when a different user is logged in" do
      render_views
      before do
        sign_in other_user
      end

      it "declares that there is no such order" do
        get :show, params: {id: order.id}
        expect(response.body).to match("No Order found with this ID")
      end
    end

    context "when a user is not logged in" do
      it 'redirects to login' do
        get :show, params: {id: order.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end ### end of "GET #show for some order" ####################################

  describe "destroy an order" do
    let!(:order) { Order.create!(user: user, product: product) }
    let!(:order2) { Order.create!(user: other_user, product: product) }
    context "when an admin is logged in" do
      before do
        sign_in admin
      end

      it "deletes this order" do
        delete :destroy, params: {id: order.id}
        expect(Order.all.to_a).to eq [order2]
      end
    end

    context "when the user of this order is logged in" do
      before do
        sign_in user
      end

      it "does not delete this order" do
        delete :destroy, params: {id: order.id}
        expect(Order.all.first).to eq order
      end
    end
  end ### end of "destroy an order" ############################################
end
