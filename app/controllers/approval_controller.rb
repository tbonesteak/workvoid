class ApprovalController < ApplicationController
  before_filter :authenticate_user!
  before_filter do 
    redirect_to home_path unless user_signed_in? && current_user.admin?
  end

  def index
    @posts = Post.order("created_at desc").page(params[:page]).per_page(50)
  end


  def edit
    @post = Post.find(params[:id])
    # redirect_to approval_path
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to approval_index_path, notice: 'This post has been updated. Keep up the good work! -Jon' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

end