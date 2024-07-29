class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :permission_denied

  before_action :authenticate_user!

  private

  def permission_denied
    flash[:error] = "You are not allowed to perform this action"
    redirect_back(fallback_location: root_path)
  end

end
