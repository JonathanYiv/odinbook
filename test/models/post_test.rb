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

  # Test dependent destruction and associations
  test "dependent destruction and associations" do
    skip("Incomplete")
  end
end
