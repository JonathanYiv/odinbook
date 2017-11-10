require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @post = create(:post, user: @user)
  end

  test "Create Authorization - POST posts_path" do
    # Logged Out User
    post posts_path, params: { post: { content: "This is totally content!" } }
    assert_not flash.empty?
    assert_redirected_to root_path

    # Logged In User
    sign_in @user
    post posts_path, params: { post: { content: "This is totally content!" } }
    assert_redirected_to root_path
  end

  test "Destroy Authorization - DELETE post_path(:id)" do
    # Logged Out User
    delete post_path(@post)
    assert_not flash.empty?
    assert_redirected_to root_path

    # Logged In User and Incorrect Post
    sign_in @user
    assert_difference 'Post.count', 0 do
      delete post_path(Post.last)
    end
    assert_not flash.empty?
    assert_redirected_to root_path

    # Logged In User and Correct Post
    assert_difference 'Post.count', -1 do
      delete post_path(@post)
    end
    assert_redirected_to root_path
  end
end
