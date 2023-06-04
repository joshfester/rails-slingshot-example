class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_current

  rescue_from ActionPolicy::Unauthorized, with: :user_not_authorized

  private

  def set_current
    Current.user = current_user
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action"
    redirect_back(fallback_location: root_path)
  end
end
