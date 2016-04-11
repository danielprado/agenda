require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create user with all mandatory fields " do
    user = User.new(:email => "test@email.com", :password => "somesecret")

    assert user.save
  end

  test "should not save user without password" do
   user = User.new(:email => "me@email.com")

   assert_not user.save
  end

  test "should not save user without email" do
   user = User.new(:password => "somesecret")

   assert_not user.save
  end

end
