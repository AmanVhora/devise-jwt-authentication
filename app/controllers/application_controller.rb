class ApplicationController < ActionController::API
  include CurrentUser
  include Pagy::Backend
end
