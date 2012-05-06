require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  context "sign up" do
  
    should "show the new user page" do
      get :new
      assert assigns(:user)
      assert assigns(:user).new_record?
    end
    
    should "create a user when given valid parameters" do
      assert_difference "User.count", +1 do
        post :create, user: {email: 'jane@company.com',
                             password: 'catsanddogs',
                             password_confirmation: 'catsanddogs'}
        assert_response :redirect
        assert_redirected_to root_path
        assert flash[:notice]

        welcome_email = ActionMailer::Base.deliveries.last
        assert welcome_email
        assert_equal ['jane@company.com'], welcome_email.to
      end
    end
    
    should "not create a user when given invalid parameters" do
      assert_difference "User.count", 0 do
        post :create, user: {password: 'catsanddogs',
                             password_confirmation: 'catsanddogs'}
        assert_response :success
        assert_template :new
        assert assigns(:user)
        assert !assigns(:user).valid?
      end
    end
    
  end
  
  context "Managing user's settings" do
    setup do
      @user = Factory(:user)
      login_as(@user)
      get :edit, id: @user.id
    end
    
    should respond_with(:success)
    should assign_to(:user).with { @user }
  end

  context "Changing user's locale" do
    setup do
      @user = Factory(:user)
      login_as(@user)
      @target_locale = "fi"
      put :update, id: @user.id, user: { locale: @target_locale }
    end
    
    should respond_with(:redirect)
    should set_the_flash

    should "update user with new locale" do
      assert_equal assigns(:user).locale, @target_locale
    end
    
    should "redirect user to edit page" do
      assert_redirected_to edit_user_path(assigns(:user))
    end
  end
end
