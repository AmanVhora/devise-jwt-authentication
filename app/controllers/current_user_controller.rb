class CurrentUserController < ApplicationController
  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10

    pagy, users = pagy(User.all, items: per_page, page: page)
    render json: users, status: :ok
  end
  
  def show
    render json: @current_user, status: :ok
    render json: { message: "Coudn't find an active session!" }, status: :unauthorized unless @current_user
  end
end
