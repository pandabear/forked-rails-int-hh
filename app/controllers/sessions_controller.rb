class SessionsController < ApplicationController
  
  skip_before_filter :authorize, only: [:new, :create]
  
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      reset_session
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = t('.flash.error.login_fail')
      render :new
    end
  end
  
  def destroy
    reset_session
    redirect_to new_session_path
  end
  
  
end
