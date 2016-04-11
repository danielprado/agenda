class Api::V1::BaseController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  layout false
  respond_to :json
end
