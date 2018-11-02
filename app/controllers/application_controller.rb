class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(is_logged: true) if !User.find_by(is_logged: true).nil?
  end
end
