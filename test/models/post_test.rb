require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # Setup Factories and Default Post
  FactoryBot.define do
    factory :post do
      content "Woo! This is a test post!"
      user
    end
  end

  def setup
    @post = build(:post)
  end

  # Default Post is valid
  test "post should be valid" do
    assert @post.valid?
  end

  # Tests presence validation
  test "content must be present" do
    @post.content = nil
    assert_not @post.valid?
  end

  # Tests length validation
  test "post can not be too long" do
    @post.content = "A" * 501
    assert_not @post.valid?
  end

  test "post can not be empty" do
    @post.content = "  "
    assert_not @post.valid?
  end

  # Test Post/Like and Post/Comment dependent destruction
  test "destroying post destroys associated likes" do
    @post.save
    create(:like, likeable: @post)
    assert_equal Like.count, 1
    assert_difference 'Like.count', -1 do
      @post.destroy
    end
  end

  test "destroying post destroys associated comments" do
    @post.save
    create(:comment, post: @post)
    assert_equal Comment.count, 1
    assert_difference 'Comment.count', -1 do
      @post.destroy
    end
  end
end
