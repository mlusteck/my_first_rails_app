require 'rails_helper'

describe ProductsController, type: :controller do
  let(:admin) { FactoryBot.create(:admin) }
  let(:other_user) { FactoryBot.create(:user) }
  let!(:product) { FactoryBot.create(:product) }

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

    ["non-admin user", "no user"].each do |unauthorized_editor|
      context "when #{unauthorized_editor} is logged in" do
        before do
          if(unauthorized_editor == "non-admin user")
            sign_in other_user
          end
        end

        it "redirects to the root page" do
          get :edit, params: {id: product.id }
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end ### end of "GET #edit for some product" ##################################

  describe "GET #new" do
    context "when a admin user is logged in" do
      before do
        sign_in admin
      end

      it "shows the new product page" do
        get :new
        expect(response).to render_template('new')
      end
    end

    ["non-admin user", "no user"].each do |unauthorized_editor|
      context "when #{unauthorized_editor} is logged in" do
        before do
          if(unauthorized_editor == "non-admin user")
            sign_in other_user
          end
        end

        it "redirects to the root page" do
          get :new
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end ### end of "GET #new" ####################################################

  describe "POST #create" do
    let(:new_product) { FactoryBot.build(:product, name:"new beast") }

    context "when an admin is logged in" do
      before do
        sign_in admin
      end

      context "when the new product is valid" do
        it 'creates the product successfully' do
          post :create, params: {  product: new_product.attributes }
          expect(Product.search("new").first.name).to eq("new beast")
        end
      end

      context "when the new product has no name" do
        it 'does not create the product and shows the new product page' do
          new_product.name = ""
          post :create, params: {  product: new_product.attributes }
          expect(Product.all.to_a).to eq [product]
          expect(response).to render_template('new')
        end
      end
    end

    ["non-admin user", "no user"].each do |unauthorized_editor|
      context "when #{unauthorized_editor} is logged in" do
        before do
          if(unauthorized_editor == "non-admin user")
            sign_in other_user
          end
        end

        it "does not create the product and redirects to the root page" do
          post :create, params: {  product: new_product.attributes }
          expect(Product.all.to_a).to eq [product]
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end ### end of "POST #create" ################################################

  describe "PUT #update" do
    let(:updated_product) { FactoryBot.build(:product, name:"new beast") }

    context "when an admin is logged in" do
      before do
        sign_in admin
      end

      context "when the product update is valid" do
        it 'updates the product successfully' do
          put :update, params: {  product: updated_product.attributes, id: product.id }
          expect(Product.first.name).to eq("new beast")
        end
      end

      context "when the product update has no name" do
        before do
          updated_product.name = ""
        end

        it 'does not change the product' do
          put :update, params: {  product: updated_product.attributes, id: product.id }
          expect(Product.all.to_a).to eq [product]
        end
      end
    end

    ["non-admin user", "no user"].each do |unauthorized_editor|
      context "when #{unauthorized_editor} is logged in" do
        before do
          if(unauthorized_editor == "non-admin user")
            sign_in other_user
          end
        end

        it "does not change the product and redirects to the root page" do
          put :update, params: {  product: updated_product.attributes, id: product.id }
          expect(Product.all.to_a).to eq [product]
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end ### end of "PUT #update" ################################################

  describe "DELETE #destroy" do
    let!(:product2) { FactoryBot.create(:product) }

    context "when an admin is logged in" do
      before do
        sign_in admin
      end

      it 'deletes the product' do
        delete :destroy, params: { id: product.id }
        expect(Product.all.to_a).to eq [product2]
      end
    end

    ["non-admin user", "no user"].each do |unauthorized_editor|
      context "when #{unauthorized_editor} is logged in" do
        before do
          if(unauthorized_editor == "non-admin user")
            sign_in other_user
          end
        end

        it "does not delete the product and redirects to the root page" do
          delete :destroy, params: { id: product.id }
          expect(Product.all.to_a).to eq [product, product2]
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end ### end of "DELETE #destroy" #############################################
end
