class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_current

  private

  def set_current
    Current.user = current_user
  end
end
