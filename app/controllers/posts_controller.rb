class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy authorize_user]
  before_action :authorize_user, only: %i[ update destroy ]

  # GET /posts
  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10

    pagy, posts = pagy(Post.all, items: per_page, page: page)
    render json: posts, status: :ok
  end

  # GET /posts/1
  def show
    render json: @post, status: :ok
  end

  # POST /posts
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      render json: { message: 'Post created successfully', post: @post }, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: { message: 'Post updated successfully', post: @post }, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    render json: { message: 'Post deleted successfully', post: @post }, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      begin
        @post = Post.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { message: 'Post not found' }
      end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body)
    end

    # Authorize User
    def authorize_user
      render json: { message: 'You are not authorize to perform this action' }, status: :unauthorized if @post.user != @current_user
    end
end
