require "test_helper"
require "action_policy/test_helper"

class Teams::MembershipsControllerEditTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include ActionPolicy::TestHelper
  
  setup do 
    @team = FactoryBot.create :team
  end

  def test_anon
    membership = FactoryBot.create :membership, :with_user, team: @team

    get edit_team_membership_url(@team, membership)

    assert_redirected_to new_user_session_url
    follow_redirect!
    assert_response :success
  end

  def test_non_admin
    user = FactoryBot.create :user
    FactoryBot.create :membership, user: user, team: @team
    membership = FactoryBot.create :membership, :with_user, team: @team
    sign_in user

    get edit_team_membership_url(@team, membership)

    assert_redirected_to root_url
    follow_redirect!
    assert_response :success
  end

  def test_success
    user = FactoryBot.create :user
    FactoryBot.create :membership, user: user, team: @team, role: "admin"
    membership = FactoryBot.create :membership, :with_user, :admin, team: @team
    sign_in user

    assert_authorized_to :edit?, membership do
      get edit_team_membership_url(@team, membership)
    end

    assert_response :success
    assert_select "form[method=post][action='#{team_membership_path(@team, membership)}']", 1 do
      assert_select "[name='membership[role]']", 1
      assert_select "[type=submit]", 1
    end
    
  end
  
end
