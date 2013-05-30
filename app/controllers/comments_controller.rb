class CommentsController < ApplicationController
  before_filter :authenticate_user!

  # GET /comments
  # GET /comments.json
  def index
    #@comments = Comment.all
    @comments = Comment.where(:post_id => params[:post_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = current_user.comments.new
    #@comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    #@comment = current_user.comments.find(params[:id])
    @admin = user_signed_in?&&current_user.admin?
    @comment = Comment.find(params[:id])
    if @comment.user == current_user || @admin
      render "edit"
    else flash[:alert] = "You do not have permission to do that."
      redirect_to :back
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    #@post = current_user.posts.find(params[:post_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        #format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.html { redirect_to :back, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    #@comment = current_user.comments.find(params[:id])
    @admin = user_signed_in?&&current_user.admin?
    @comment = Comment.find(params[:id])
    if @comment.user == current_user || @admin
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        #format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.html { redirect_to :back, notice: 'Comment was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
    else flash[:alert] = "You do not have permission to do that."
      redirect_to :back
    end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @admin = user_signed_in?&&current_user.admin?
    @comment = current_user.comments.find(params[:id])
    if @comment.user == current_user || @admin
      @comment.destroy
    else flash[:alert] = "You do not have permission to do that."
      redirect_to :back

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end
end