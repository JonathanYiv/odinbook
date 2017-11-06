require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  # Setup Factories and Default Like
  FactoryBot.define do
    factory :like do
      user
      association :likeable, factory: :post
    end

    factory :post_like, class: Like do
      user
      association :likeable, factory: :post
    end

    factory :comment_like, class: Like do
      user
      association :likeable, factory: :comment
    end
  end

  def setup
    @post_like = build(:post_like)
    @comment_like = build(:comment_like)
  end

  # Default Like is valid
  test "like should be valid" do
    assert @post_like.valid?
    assert @comment_like.valid?
  end
end
