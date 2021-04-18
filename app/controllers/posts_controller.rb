class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = current_user.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      @status = true
    else
      @status = false
    end
    redirect_to(posts_url)
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      @status = true
    else
      @status = false
    end
    redirect_to(posts_url)
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to(posts_url)
  end

  private
    def set_post
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to(posts_url, alert: "ERROR!!") if @post.blank?
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
