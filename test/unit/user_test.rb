require 'test_helper'

class UserTest < ActiveSupport::TestCase

  context "user instance" do
    
    subject { Factory(:user) }
    
    should validate_presence_of   :email
    should validate_uniqueness_of :email
    
  end

  context "serializing" do

    setup do
      @email = 'h@dou.ken'
      @password = 'mah_password'
      @user = Factory(:user, email: @email, password_digest: @password)
    end

    should "serialize email" do
      assert_match /#{@email}/, @user.to_json
    end

    should "not serialize password_digest" do
      assert_no_match /#{@password}/, @user.to_json
    end

  end

end
