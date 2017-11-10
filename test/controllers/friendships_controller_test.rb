require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @potential_friend = create(:user)
    @nonfriend = create(:user)
    @friend = create(:user)
    @friendship = create(:friendship, requester: @user, requested: @friend, accepted: true)
    @friend_request = create(:friendship, requester: @user, requested: @nonfriend, accepted: false)
  end

  test "Index Authorization - GET friendships_path" do
    # Logged Out User
    get friendships_path
    assert_not flash.empty?
    assert_redirected_to root_path

    # Logged In User
    sign_in @user
    get friendships_path
    assert_response :success
  end

  test "Create Authorization - POST friendships_path" do
    # Logged Out User
    post friendships_path, params: { friend_id: @potential_friend.id }
    assert_not flash.empty?
    assert_redirected_to root_path
    # I realized this might be more meaningful considering root_path also points to the NewsFeed.
    # follow_redirect!
    # assert_template 'logout/_page'

    # Logged In User - Already Friends
    assert @user.friend?(@friend)
    sign_in @user
    post friendships_path, params: { friend_id: @friend.id }
    assert_not flash.empty?
    assert_redirected_to @friend

    # Logged In User - Not Friends Yet
    assert_not @user.friend?(@potential_friend)
    assert_difference 'Friendship.count', 1 do
      post friendships_path, params: { friend_id: @potential_friend.id }
    end
    assert_redirected_to root_path
  end

  test "Destroy Authorization - DELETE friendship_path(:id)" do
    # Logged Out User
    assert_no_difference 'Friendship.count' do
      delete friendship_path(@friendship)
    end
    assert_not flash.empty?
    assert_redirected_to root_path

    # Incorrect User
    sign_in @user
    assert_no_difference 'Friendship.count' do
      delete friendship_path(Friendship.first)
    end
    assert_not flash.empty?
    assert_redirected_to root_path

    # Logged In User
    assert_difference 'Friendship.count', -1 do
      delete friendship_path(@friendship)
    end
  end

  test "Accept Authorization - POST accept_path(:id)" do
    # Logged Out User
    post accept_path, params: { id: @friend_request.id }
    assert_not flash.empty?
    assert_redirected_to root_path

    # Incorrect User
    sign_in @potential_friend
    assert_no_difference 'Friendship.where(accepted: true).count' do
      post accept_path, params: { id: @friend_request.id }
    end
    assert_not flash.empty?
    assert_redirected_to root_path

    # Correct User - Already Friends
    sign_in @user
    assert_no_difference 'Friendship.where(accepted: true).count' do
      post accept_path, params: { id: @friendship.id }
    end

    # Valid Friend Request - Requester
    assert_no_difference 'Friendship.where(accepted: true).count' do
      post accept_path, params: { id: @friend_request.id }
    end
    assert_not flash.empty?
    assert_redirected_to root_path

    # Valid Friend Request - Requested
    # sign_in @nonfriend
    # assert_difference 'Friendship.where(accepted: true).count', 1 do
    #   post accept_path, params: { id: @friend_request.id }
    # end
    # assert_not flash.empty?
    # assert_redirected_to @friend_request.requester
    skip("This is having some issues..")
  end 
end
