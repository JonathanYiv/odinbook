require 'test_helper'

class AuthorizationTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
  end

  # Testing generic login/logout 
  test "log in works" do
    get root_path
    assert_template 'static_pages/_logout_home'
    sign_in @user
    follow_redirect!
    assert_template 'static_pages/_login_home'
  end

  # Test page access levels

    # users_path
  test "can't see users if logged out" do
    # Logged Out User
    get users_path
    assert_redirected_to root_path
    assert_not flash.empty?

    # Signed In User
    sign_in @user
    get users_path
    assert_response(200)
  end

    # user_path(:id)
  test "can't see specific user if logged out" do
    # Logged Out User
    get user_path(1)
    assert_redirected_to root_path
    assert_not flash.empty?

    # Signed In User
    sign_in @user
    get user_path(User.last.id)
    assert_not flash.empty?
  end

  # Need tests for every route
end
