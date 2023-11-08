module CurrentUser
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
  end

  def set_current_user
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split(' ').last
      jwt_payload = JWT.decode(token, ENV['devise_jwt_secret_key']).first
      @current_user ||= User.find(jwt_payload['sub'])
    end
  end
end
