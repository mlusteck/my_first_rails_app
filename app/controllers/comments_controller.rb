class CommentsController < ApplicationController
  include CommentsHelper
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @product = Product.find(params[:product_id])
    @comments = @product.comments.order("created_at DESC").paginate(page: params[:page], per_page: 4)
    if @product
      respond_to do |format|
        format.js   # we want to do this with AJAX
      end
    end
  end

  def show
    @comment = Comment.find(params[:id])
    if @comment
      @product = @comment.product
      respond_to do |format|
        format.js   # we want to do this with AJAX
      end
    end
  end

  def edit
    @comment = find_comment params[:id]
    if @comment
      @product = @comment.product
      respond_to do |format|
        format.html { redirect_to @product  }
        format.json { render :show, status: :created, location: @product }
        format.js   # we want to do this with AJAX
      end
    end
  end

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @product, notice: 'Review was created successfully.' }
        format.json { render :show, status: :created, location: @product }
        format.js   # we want to do this with AJAX
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

  def update
    @comment = find_comment params[:id]
    if @comment
      @product = @comment.product
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to @product  }
          format.json { render :show, status: :created, location: @product }
          format.js   # we want to do this with AJAX
          return
        else
          format.html { redirect_to @product, alert: 'Comment was not updated.' }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
          return
        end
      end
    end
    redirect_to @product
  end

  def destroy
    @comment = find_comment params[:id]
    if @comment
      @product = @comment.product
      @destroyed_comment_id = @comment.html_id
      respond_to do |format|
        if @comment.destroy
          format.html { redirect_to @product  }
          format.json { render :show, status: :created, location: @product }
          format.js   # we want to do this with AJAX
          return
        else
          format.html { redirect_to @product, alert: 'Comment was not destroyed.' }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
    redirect_to product
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit( :body, :rating)
    end
end
