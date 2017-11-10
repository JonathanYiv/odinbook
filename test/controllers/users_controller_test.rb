require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
  end

  test "Index Authorization - GET users_path" do
    # Logged Out User
    get users_path
    assert_redirected_to root_path
    assert_not flash.empty?

    # Signed In User
    sign_in @user
    get users_path
    assert_response(200)
  end

  test "Show Authorization - GET user_path(:id)" do
    # Logged Out User
    get user_path(1)
    assert_redirected_to root_path
    assert_not flash.empty?

    # Signed In User
    sign_in @user
    get user_path(User.last.id)
    assert_not flash.empty?
  end

  test "Update Authorization - PATCH/PUT user_path(:id)" do
    # Logged Out User
    patch user_path(User.last), params: { user: { bio: "I am a bio of darkness!" } }
    assert_not flash.empty?
    assert_redirected_to root_path

    # Incorrect User
    sign_in @user
    patch user_path(User.first), params: { user: { bio: "I am a bio of darkness!" } }
    assert_not flash.empty?
    assert_redirected_to root_path

    # Correct User
    patch user_path(@user), params: { user: { bio: "I am a bio of darkness!" } }
    assert_not_equal @user.bio, @user.reload.bio
  end

  test "Destroy Authorization - DELETE user_path(:id)" do
    # Logged Out User
    delete user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_path

    # Incorrect User
    sign_in @user
    delete user_path(User.first)
    assert_not flash.empty?
    assert_redirected_to root_path

    # Correct User
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
  end
end
