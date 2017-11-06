require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  # Setup Factories and Default Friendship
  FactoryBot.define do
    factory :friendship do
      association :requester, factory: :user
      association :requested, factory: :user
    end
  end

  def setup
    @friendship = build(:friendship)
  end

  # Default Friendship is valid
  test "friendship should be valid" do
    assert @friendship.valid?
  end
end
