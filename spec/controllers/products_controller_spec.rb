require 'rails_helper'

describe ProductsController, type: :controller do
  let(:admin) { User.create!(email: "spec@example.com", password: "1234567", admin: true) }
  let(:other_user) { User.create!(email: "user@other_example.com", password: "asdfghjk") }
  let(:product) { Product.create!(name: "speculum") }

  context "GET #index" do
    it 'renders the index template' do
      get :index
      expect(response).to be_ok
      expect(response).to render_template('index')
    end
  end

  context "GET #show for some product" do
    it 'shows the product' do
      get :show, params: {id: product.id }
      expect(response).to be_ok
      expect(response).to render_template('show')
    end
  end

  describe "GET #edit for some product" do
    context "when a non-admin user is logged in" do
      before do
        sign_in other_user
      end

      it "redirects to the root page" do
        get :edit, params: {id: product.id }
        expect(response).to redirect_to(root_path)
      end
    end


    context "when a admin user is logged in" do
      before do
        sign_in admin
      end

      it "shows the edit page of this product" do
        get :edit, params: {id: product.id }
        expect(assigns(:product)).to eq product
        expect(response).to render_template('edit')
      end
    end

    context "when a user is not logged in" do
      it "redirects to the root page" do
        get :edit, params: {id: product.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #new" do
    context "when a non-admin user is logged in" do
      before do
        sign_in other_user
      end

      it "redirects to the root page" do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end


    context "when a admin user is logged in" do
      before do
        sign_in admin
      end

      it "shows the new product page" do
        get :new
        expect(response).to render_template('new')
      end
    end

    context "when a user is not logged in" do
      it "redirects to the root page" do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
