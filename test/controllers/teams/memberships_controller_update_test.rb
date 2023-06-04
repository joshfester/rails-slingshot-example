require "test_helper"
require "action_policy/test_helper"

class Teams::MembershipsControllerUpdateTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include ActionPolicy::TestHelper
  
  setup do 
    @team = FactoryBot.create :team
  end

  def test_anon
    membership = FactoryBot.create :membership, :with_user, team: @team

    put team_membership_url(@team, membership)

    assert_redirected_to new_user_session_url
    follow_redirect!
    assert_response :success
  end

  def test_non_admin
    user = FactoryBot.create :user
    FactoryBot.create :membership, user: user, team: @team
    membership = FactoryBot.create :membership, :with_user, team: @team
    sign_in user

    put team_membership_url(@team, membership)

    assert_redirected_to root_url
    follow_redirect!
    assert_response :success
  end

  # Can't destroy if it's the only admin
  def test_min_admins
    user = FactoryBot.create :user
    membership = FactoryBot.create :membership, user: user, team: @team, role: "admin"
    FactoryBot.create :membership, :with_user, team: @team, role: "member"
    sign_in user

    put team_membership_url(@team, membership), params: {
      membership: { role: "member" }
    }

    assert_redirected_to edit_team_membership_url(@team, membership)
    follow_redirect!
    assert_response :success
    assert_equal "admin", membership.role
    assert_select ".alert", 1
  end

  def test_success
    user = FactoryBot.create :user
    FactoryBot.create :membership, user: user, team: @team, role: "admin"
    membership = FactoryBot.create :membership, :with_user, :admin, team: @team
    sign_in user

    assert_authorized_to :update?, membership do
      put team_membership_url(@team, membership), params: {
        membership: { role: "member" }
      }
    end

    assert_redirected_to team_url(@team)
    follow_redirect!
    assert_response :success
  end
  
end
