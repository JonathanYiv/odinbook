require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @comment = create(:comment, user: @user)
    @post = create(:post)
  end

  test "Create Authorization - POST comments_path" do
    # Logged Out User
    post comments_path, params: { comment: { content: "This is totally content!", post_id: @post.id } }
    assert_not flash.empty?
    assert_redirected_to root_path

    # Logged In User
    sign_in @user
    post comments_path, params: { comment: { content: "This is totally content!", post_id: @post.id } }
    assert_redirected_to root_path
  end

  test "Destroy Authorization - DELETE comment_path(:id)" do
    # Logged Out User
    delete post_path(@comment)
    assert_not flash.empty?
    assert_redirected_to root_path

    # Logged In User and Incorrect Comment
    sign_in @user
    assert_difference 'Comment.count', 0 do
      delete comment_path(Comment.first)
    end
    assert_not flash.empty?
    assert_redirected_to root_path

    # Logged In User and Correct Post
    assert_difference 'Comment.count', -1 do
      delete comment_path(@comment)
    end
    assert_redirected_to root_path
  end
end
