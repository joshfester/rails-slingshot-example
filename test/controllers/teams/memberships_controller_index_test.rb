require "test_helper"
require "action_policy/test_helper"

class Teams::MembershipsControllerIndexTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include ActionPolicy::TestHelper
  
  setup do 
    @team = FactoryBot.create :team
  end

  def test_get_index_anon
    get team_memberships_url(@team)
    assert_redirected_to new_user_session_url
    follow_redirect!
    assert_response :success
  end

  def test_get_index_non_admin
    user = FactoryBot.create :user
    FactoryBot.create :membership, user: user, team: @team
    FactoryBot.create_list :membership, 21, :with_user, team: @team
    sign_in user

    get team_memberships_url(@team)

    assert_response :success
    assert_select ".memberships-list-item", 20

    @team.memberships.find_each do |membership|
      assert_select "form[action='#{team_membership_path(@team, membership)}']", 0
      assert_select "a[href='#{edit_team_membership_path(@team, membership)}']", 0
    end
  end

  def test_get_index_admin
    user = FactoryBot.create :user
    membership = FactoryBot.create :membership, user: user, team: @team, role: "admin"
    FactoryBot.create_list :membership, 21, :with_user, team: @team
    sign_in user

    get team_memberships_url(@team)

    assert_response :success
    assert_select ".memberships-list-item", 20
    
    @team.memberships.order(created_at: :desc).limit(20).each do |membership|
      assert_select "form[action='#{team_membership_path(@team, membership)}']", 1
      assert_select "a[href='#{edit_team_membership_path(@team, membership)}']", 1
    end
  end
  
end
