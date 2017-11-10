require 'test_helper'

class AuthorizationTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
  end

  # Where does this test go?
  # Testing generic login/logout 
  test "log in works" do
    get root_path
    assert_template 'static_pages/_logout_home'
    sign_in @user
    follow_redirect!
    assert_template 'static_pages/_login_home'
  end
end
