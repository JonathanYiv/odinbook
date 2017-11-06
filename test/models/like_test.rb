require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  # Setup Factories and Default Like
  FactoryBot.define do
    factory :like do
      user
      association :likeable, factory: :post
    end
  end

  def setup
    @like = build(:like)
  end

  # Default Like is valid
  test "like should be valid" do
    assert @like.valid?
  end

  # Test dependent destruction and associations
  test "dependent destruction and associations" do
    skip("Incomplete")
  end
end
