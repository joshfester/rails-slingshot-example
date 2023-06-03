require "test_helper"
require "action_policy/test_helper"

class Teams::MembershipsControllerDestroyTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include ActionPolicy::TestHelper
  
  setup do 
    @team = FactoryBot.create :team
  end

  def test_anon
    membership = FactoryBot.create :membership, :with_user, team: @team

    assert_difference "Membership.count", 0 do
      delete team_membership_url(@team, membership)
    end

    assert_redirected_to new_user_session_url
    follow_redirect!
    assert_response :success
  end

  def test_non_admin
    user = FactoryBot.create :user
    FactoryBot.create :membership, user: user, team: @team
    membership = FactoryBot.create :membership, :with_user, team: @team
    sign_in user

    assert_difference "Membership.count", 0 do
      delete team_membership_url(@team, membership)
    end

    assert_redirected_to root_url
    follow_redirect!
    assert_response :success
  end

  # Can't destroy if it's the only admin
  def test_min_admins
    user = FactoryBot.create :user
    FactoryBot.create :membership, user: user, team: @team, role: "admin"
    membership = FactoryBot.create :membership, :with_user, team: @team
    sign_in user

    assert_difference "Membership.count", 0 do
      delete team_membership_url(@team, membership)
    end

    assert_redirected_to root_url
    follow_redirect!
    assert_response :success
  end

  def test_success_other
    user = FactoryBot.create :user
    FactoryBot.create :membership, user: user, team: @team, role: "admin"
    membership = FactoryBot.create :membership, :with_user, :admin, team: @team
    sign_in user

    assert_difference "Membership.count", -1 do
      assert_authorized_to :destroy?, membership do
        delete team_membership_url(@team, membership)
      end
    end

    assert_redirected_to team_url(@team)
    follow_redirect!
    assert_response :success
  end

  def test_success_self
    user = FactoryBot.create :user
    membership = FactoryBot.create :membership, user: user, team: @team, role: "admin"
    FactoryBot.create :membership, :with_user, :admin, team: @team
    sign_in user

    assert_difference "Membership.count", -1 do
      assert_authorized_to :destroy?, membership do
        delete team_membership_url(@team, membership)
      end
    end

    assert_redirected_to root_url
    follow_redirect!
    assert_response :success
  end
  
end
