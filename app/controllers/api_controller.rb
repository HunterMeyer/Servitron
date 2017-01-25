class ApiController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :validate_api_key

  private

  def validate_api_key
    return missing_api_key unless params.key?(:key)
    return access_denied unless current_api_user.try(:api_enabled?)
  end

  def current_api_user
    return @current_api_user if defined? @current_api_user
    @current_api_user = User.find_by_api_key(params[:key])
  end

  def missing_api_key
    access_denied('Missing API Key')
  end

  def access_denied(message = 'Access Denied')
    render json: { error: message }, status: :unauthorized
  end
end
