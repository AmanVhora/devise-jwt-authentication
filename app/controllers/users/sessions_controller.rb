# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include RackSessionsFix
  respond_to :json
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private
  def respond_with(current_user, _opts = {})
    render json: { message: 'Logged in successfully!', data: current_user }, status: :ok
  end

  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split(' ').last
      jwt_payload = JWT.decode(token, ENV['devise_jwt_secret_key']).first
      current_user = User.find(jwt_payload['sub'])
    end

    if current_user
      render json: { message: 'Logged out successfully!' }, status: :ok
    else
      render json: { message: "Coudn't find an active session!" }, status: :unauthorized
    end
  end
end
