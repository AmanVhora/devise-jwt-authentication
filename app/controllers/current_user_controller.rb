class CurrentUserController < ApplicationController
  def index
    users = User.all
    render json: users, status: :ok
  end
  
  def show
    render json: @current_user, status: :ok
    render json: { message: "Coudn't find an active session!" }, status: :unauthorized unless @current_user
  end
end
