class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authorize
  before_filter :set_locale

  protected 
  
  def pjax_layout
    'pjax'
  end

  def available_locales
    # fi as in emoticon! (DON'T ASK ME WHY!)
    locales = %w(fi en)
    locales.sort
  end
  helper_method :available_locales

  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  def authorize
    redirect_to new_session_path if current_user.nil?
  end

  def set_locale
    if current_user && available_locales.include?(current_user.locale)
      I18n.locale = current_user.locale
    else
      I18n.locale = request.compatible_language_from(available_locales) || I18n.default_locale
    end
  end
end
