class Api::V1::TokenAuthenticationsController < Api::V1::BaseController
  before_filter :verify_authenticity_token, :only =>[:destroy]

  before_filter :ensure_params_exist, :only =>[:create]
  before_filter :ensure_json_format

  before_filter :authenticate_user! , :only =>[]

  def create
    email=params[:email]
    password=params[:password]

    @user= User.find_by_email(email.downcase)

    return invalid_login_attempt unless @user

    # http://rdoc.info/github/plataformatec/devise/master/Devise/Models/TokenAuthenticatable
    @user.ensure_authentication_token

    if not @user.valid_password?(password)
      logger.info("User #{email} failed sign in, password \"#{password}\" is invalid")
      render :status=>401, :json=>{:message=>"Invalid email or password."}
    else
      render :status=>200, :json=>{:token=>@user.authentication_token, :id=> @user.id}
    end
  end

  def destroy
    @user=User.find_by_authentication_token(params[:id])
    if @user.nil?
      logger.info("Token not found.")
      render :status=>404, :json=>{:message=>"Invalid token."}
    else
      @user.reset_authentication_token!
      render :status=>200, :json=>{:token=>params[:id]}
    end
  end

  protected

  def ensure_params_exist
    if params[:email].nil? or params[:password].nil?
     render :status=>400, :json=>{:message=>"The request must contain the user email and password."}
    end
  end

  def ensure_json_format
    if request.format != :json
      render :status=>406, :json=>{:message=>"The request must be json"}
    end
  end

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end

end
