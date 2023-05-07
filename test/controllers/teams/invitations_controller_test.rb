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

  def test_post_create_anon
    invite_email = "gandalf@middleearth.net"

    assert_difference "Invitation.count", 0 do
      post team_invitations_url(@team), params: {
        invitation: {email: invite_email}
      }
    end

    assert_redirected_to root_url
    follow_redirect!
    assert_response :success
  end

  def test_post_create
    invite_email = "gandalf@middleearth.net"
    user = FactoryBot.create :user
    @team.memberships.create user: user
    sign_in user

    assert_difference "Invitation.count", 0 do
      post team_invitations_url(@team), params: {
        invitation: {email: invite_email}
      }
    end

    assert_redirected_to root_url
    follow_redirect!
    assert_response :success
  end

  def test_post_create
    invite_email = "gandalf@middleearth.net"
    user = FactoryBot.create :user
    @team.memberships.create user: user, role: "admin"
    sign_in user

    assert_difference "Invitation.count", 1 do
      assert_authorized_to :create?, :invitation do
        post team_invitations_url(@team), params: {
          invitation: {email: invite_email}
        }
      end
    end

    assert_redirected_to team_url(@team)
    follow_redirect!
    assert_response :success
    assert_equal invite_email, Invitation.last.email
    assert_equal user.id, Invitation.last.from_membership.user_id
    assert_equal @team.id, Invitation.last.from_membership.team_id
  end
end
