require "test_helper"
require "action_policy/test_helper"

class Teams::InvitationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include ActionPolicy::TestHelper
  
  setup do 
    @team = FactoryBot.create :team
  end

  def test_get_new_anon
    get new_team_invitation_url(@team)
    assert_redirected_to new_user_session_url
  end

  def test_get_new_non_admin
    user = FactoryBot.create :user
    @team.memberships.create user: user
    sign_in user

    get new_team_invitation_url(@team)

    assert_redirected_to root_url
  end

  def test_get_new
    user = FactoryBot.create :user
    @team.memberships.create user: user, role: "admin"
    sign_in user

    assert_authorized_to :new?, :invitation, context: {team: @team} do
      get new_team_invitation_url(@team)
    end

    assert_response :success
    assert_select "form[action='#{team_invitations_path(@team)}']" do 
      assert_select "input[name='invitation[email]']"
    end
  end
end
