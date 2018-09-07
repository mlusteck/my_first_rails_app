require 'rails_helper'

describe CommentsController, type: :controller do
  let(:admin) { FactoryBot.create(:admin) }
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product) }

  describe "GET #index with AJAX" do
    it 'renders the index template' do
      get :index, xhr: true, params: { product_id: product.id }
      expect(response).to be_ok
      expect(response).to render_template('index')
    end
  end

  describe "GET #show with AJAX for some comment" do
    let(:comment) { FactoryBot.create(:comment, user: user, product: product) }
    it 'shows this comment' do
      get :show, xhr: true, params: { id: comment.id, product_id: product.id }
      expect(assigns(:comment)).to eq comment
      expect(response).to be_ok
      expect(response).to render_template('show')
    end
  end

  describe "GET #edit with AJAX for some comment" do
    let(:comment) { FactoryBot.create(:comment, user: user, product: product) }
    before do
      @editors = {author: user, admin: admin }
    end

    [:author, :admin].each do |editor_role|
      context "when #{editor_role} is logged in" do
        before do
          sign_in @editors[editor_role]
        end
        it 'shows the edit form for this comment' do
          get :edit, xhr: true, params: { id: comment.id, product_id: product.id }
          expect(assigns(:comment)).to eq comment
          expect(response).to be_ok
          expect(response).to render_template('edit')
        end
      end
    end

    context "when another non-admin user is logged in" do
      before do
        sign_in other_user
      end
      it 'redirects to the root page' do
        get :edit, xhr: true, params: { id: comment.id, product_id: product.id }
        expect(response).to redirect_to(root_path)
      end
    end

    context "when no user is logged in" do
      it 'responds with status 401 (unauthorized)' do
        get :edit, xhr: true, params: { id: comment.id, product_id: product.id }
        expect(response).to have_http_status(401)
      end
    end
  end ### end of "GET #edit with AJAX for some comment" ########################

  describe "POST #create with AJAX " do
    context "when the user is logged in" do
      before do
        sign_in user
      end

      context "when the comment is valid" do
        let(:comment) {FactoryBot.build(:comment, user: user, product: product)}
        it 'creates the comment successfully' do
          post :create, xhr: true,  params: {  comment: comment.attributes,
                                    user_id: user.id,
                                    product_id: product.id }
          expect(product.comments).not_to be_empty
          first_comment = product.comments.first
          expect(first_comment.user).to eq user
          expect(first_comment.body).to eq comment.body
        end
      end

      context "when the comment is not valid" do
        it 'does not create the comment' do
          post :create, xhr: true, params: {  comment: {body:"Great!", rating: "wrong"},
                                   user_id: user.id,
                                   product_id: product.id }
          expect(product.comments).to be_empty
        end
      end
    end

    context "when no user is logged in" do
      it 'does not create a comment' do
        post :create, xhr: true, params: {  comment: {body:"Great!", rating: 5 },
                                 user_id: user.id,
                                 product_id: product.id }
        expect(product.comments).to be_empty
      end
    end
  end ### end of "POST #create with AJAX " #####################################

  describe "PUT #update with AJAX " do
    let(:comment) { FactoryBot.create(:comment, user: user, product: product) }
    before do
      @editors = {author: user, admin: admin }
    end

    [:author, :admin].each do |editor_role|
      context "when #{editor_role} is logged in" do
        before do
          sign_in @editors[editor_role]
        end
        context "when the update is valid" do
          it 'updates the comment' do
            put :update, xhr: true, params: {  comment: {body:"Bad!", rating: 1 },
                                     id: comment.id,
                                     user_id: user.id,
                                     product_id: product.id }
            expect(product.comments.find_by(id: comment.id).body).to eq "Bad!"
          end
        end

        context "when the update is not valid" do
          it 'does not update the comment' do
            put :update, xhr: true, params: {  comment: {body:"Bad!", rating: "Argh!" },
                                     id: comment.id,
                                     user_id: user.id,
                                     product_id: product.id }
            expect(product.comments.find_by(id: comment.id).body).not_to eq "Bad!"
          end
        end
      end
    end

    ["other user", "no user"].each do |unauthorized_editor|
      context "when #{unauthorized_editor} is logged in" do
        before do
          if(unauthorized_editor == "other user")
            sign_in other_user
          end
        end
        it 'does not update the comment' do
          put :update, xhr: true, params: {  comment: {body:"Bad!", rating: 1 },
                                   id: comment.id,
                                   user_id: user.id,
                                   product_id: product.id }
          expect(product.comments.find_by(id: comment.id).body).not_to eq "Bad!"
        end
      end
    end
  end ### end of "PUT #update with AJAX " ######################################

  describe "DELETE with AJAX " do
    before do
      @comment = FactoryBot.create(:comment, user: user, product: product)
      @comment2 = FactoryBot.create(:comment, body:"Nice!", user: other_user, product: product)
      @editors = {author: user, admin: admin }
    end

    [:author, :admin].each do |editor_role|
      context "when #{editor_role} is logged in" do
        before do
          sign_in @editors[editor_role]
        end
        it 'deletes the comment' do
          delete :destroy, xhr: true, params: { id: @comment.id,
                                                user_id: user.id,
                                                product_id: product.id }
          expect(product.comments.all.to_a).to eq [@comment2]
        end
      end
    end

    ["other user", "no user"].each do |unauthorized_editor|
      context "when #{unauthorized_editor} is logged in" do
        before do
          if(unauthorized_editor == "other user")
            sign_in other_user
          end
        end
        it 'does not delete the comment' do
          delete :destroy, xhr: true, params: { id: @comment.id,
                                                user_id: user.id,
                                                product_id: product.id }
           expect(product.comments.first).to eq @comment
        end
      end
    end
  end ### end of "DELETE with AJAX " ###########################################
end
