class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  def index
  @posts = params[:prefecture_id].present? ? Prefecture.find(params[:prefecture_id]).posts.where(status:1).order(created_at: :desc) : Post.where(status:1).order(created_at: :desc)
  end

  # GET /posts/1
  def show
     if @post.status_private? && @post.user != current_user
      respond_to do |format|
        format.html { redirect_to posts_path, notice: 'このページにはアクセスできません' }
      end
     end
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
    @post.user_id = current_user.id
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
  
  def private_index
    @posts = current_user.posts.where(status:0).order(created_at: :desc)
  end

  private
    def set_post
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to(posts_url, alert: "ERROR!!") if @post.blank?
    end

    def post_params
      params.require(:post).permit(
        :title,
        :content,
        :image,
        :status, # <= 追加：statusカラム
        {:cat_ids => []},
        :prefecture_id
      )
    end
end
