class ApplicationController < ActionController::Base
  before_action :set_current_user

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def set_current_user
    Current.user = current_user
    Current.user_signed_in = user_signed_in?
  end
end
