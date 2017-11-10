require 'test_helper'

class LikeControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @post = create(:post)
    @second_post = create(:post)
    @comment = create(:comment)
    @like = create(:like, user: @user, likeable: @second_post)
  end

  test "Create Authorization - POST likes_path" do
    # Logged Out User
    assert_no_difference 'Like.count' do
      post likes_path, params: { post_id: Post.first.id }
    end
    assert_not flash.empty?
    assert_redirected_to root_path

    # Logged In User
    sign_in @user
    assert_difference 'Like.count', 1 do
      post likes_path, params: { post_id: Post.first.id }
    end
    assert_redirected_to root_path
  end

  test "Like either Comment or Post" do
    sign_in @user

    # Comment
    assert_difference 'Like.count', 1 do
      post likes_path, params: { comment_id: @comment.id }
    end

    # Post
    assert_difference 'Like.count', 1 do
      post likes_path, params: { post_id: @post.id }
    end
  end

  test "Destroy Authorization - DELETE like_path(:id)" do
    # Logged Out User
    assert_no_difference 'Like.count' do
      delete like_path(@like)
    end
    assert_not flash.empty?
    assert_redirected_to root_path
    
    # Logged In User
    sign_in @user
    assert_difference 'Like.count', -1 do
      delete like_path(@like)
    end
  end
end
