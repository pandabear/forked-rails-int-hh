require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  setup do
    @user         = Factory(:user)
    @book         = Factory(:book)
    @reservation  = Factory(
      :reservation,
      book: @book,
      user: @user,
      state: 'reserved'
    )
  end

  should "deliver welcome email" do
    mail = UserMailer.welcome_email(@user)
    assert_equal [@user.email], mail.to
    assert_equal "Welcome to Library", mail.subject
    assert_match /Sign in at:.*\/session\/new/, mail.body.encoded
  end

  should "send confirmation for reservation" do
    mail = UserMailer.reservation_confirmation(@reservation)
    assert_equal [@reservation.user.email], mail.to
    assert_equal "#{@reservation.book.title} book reservation", mail.subject
    assert_match /.*\/books\/#{@reservation.book.id}/, mail.body.encoded
  end
end
