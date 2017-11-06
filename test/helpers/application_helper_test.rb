require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,          "odinbook"
    assert_equal full_title("Test"),  "Test | odinbook"
  end
end