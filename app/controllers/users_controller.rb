class UsersController < ApplicationController
  
  skip_before_filter :authorize, only: [:new, :create]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.welcome_email(@user).deliver
      flash[:notice] = t('.flash.notice.sign_up_success')
      redirect_to root_path
    else
      render :new
    end
  end
  
  ##
  # Some safety measure would've been in order
  # to prevent malicious users from editing others' 
  # information.
  #
  def edit
    @user = User.find(params[:id])
  end
  
  ##
  # Currently user can save any locale user so desire.
  # The way logic works, validation of valid locale is only
  # checked when loading a page. If it's invalid, fallback
  # locale is available.
  #
  def update
    @user = User.find(params[:id])
    @user.locale = params[:user][:locale]
    if @current_user.id === @user.id && @user.save
      flash[:notice] = t('.flash.notice.update.success')
      redirect_to edit_user_path(@user)
    else
      flash[:error] = t('.flash.error.update.fail')
      render :edit
    end
  end
end
