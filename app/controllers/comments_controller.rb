class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.new(comment_params)
    @comment.user = current_user
    @comment.save

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @product, notice: 'Review was created successfully.' }
        format.json { render :show, status: :created, location: @product }
      else
        error_text = ""
        @comment.errors.full_messages.each do |message|
          error_text += " " + message
        end

        format.html { redirect_to @product, alert: 'Review was not saved successfully.' + error_text }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if current_user.admin
      @comment = Comment.find_by(id: params[:id])
    else
      @comment = current_user.comments.find_by(id: params[:id])
    end
    if @comment
      product = @comment.product
      @comment.destroy
    end
    redirect_to product
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :body, :rating)
    end
end
