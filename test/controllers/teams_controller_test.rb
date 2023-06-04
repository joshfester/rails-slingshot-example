require "test_helper"
require "action_policy/test_helper"

class TeamsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include ActionPolicy::TestHelper

  def test_get_index_anon
    get teams_url
    assert_redirected_to new_user_session_url
  end

  def test_get_index_empty
    sign_in FactoryBot.create :user

    get teams_url

    assert_response :success
    assert_select "a[href='#{new_team_path}']"
  end

  def test_get_index
    user = FactoryBot.create :user
    FactoryBot.create_list :team, 21
    FactoryBot.create_list :team, 21, users: [user]
    team_ids = user.team_ids
    sign_in user

    get teams_url

    assert_response :success
    assert_select ".teams-list-item", 20

    assert_select ".teams-list-item" do |elements|
      assert_equal 20, elements.map { |i| i.attribute("data-id").value.to_i }.uniq.length

      elements.each do |element|
        assert team_ids.include?(element.attribute("data-id").value.to_i)
      end
    end
    
  end

  def test_get_new_anon
    get new_team_url
    assert_redirected_to new_user_session_url
  end

  def test_get_new
    user = FactoryBot.create :user
    sign_in user

    assert_authorized_to :new?, :team do
      get new_team_url
    end

    assert_response :success
  end

  def test_post_create_anon
    assert_difference "Team.count", 0 do
      post teams_url, params: {team: { title: "New Team" }}
    end

    assert_redirected_to new_user_session_url
  end

  def test_post_create
    user = FactoryBot.create :user
    title = "Team Gandalf"
    sign_in user

    assert_difference "Team.count", 1 do
      assert_authorized_to :create?, :team do
        post teams_url, params: {team: { title: title }}
      end
    end

    resource = Team.last
    membership = Membership.find_by user: user, team: resource

    assert_equal title, resource.title
    assert membership.present?
    assert_equal "admin", membership.role
    
    assert_redirected_to team_url(resource)
    follow_redirect!
    assert_response :success
  end

  def test_get_show_anon
    get team_url(FactoryBot.create(:team))
    assert_redirected_to new_user_session_url
  end

  def test_get_show_non_member
    resource = FactoryBot.create :team
    sign_in FactoryBot.create :user
    get team_url(resource)
    assert_redirected_to root_url
  end

  def test_get_show
    user = FactoryBot.create :user
    resource = FactoryBot.create :team, users: [user]
    sign_in user

    assert_authorized_to :show?, resource do
      get team_url(resource)
    end

    assert_response :success
  end

  def test_get_edit_anon
    get edit_team_url(FactoryBot.create(:team))
    assert_redirected_to new_user_session_url
  end

  def test_get_edit_non_admin
    user = FactoryBot.create :user
    resource = FactoryBot.create :team, users: [user]
    sign_in user
    get edit_team_url(resource)
    assert_redirected_to root_url
  end

  def test_get_edit
    user = FactoryBot.create :user
    resource = FactoryBot.create :team
    Membership.create! user: user, team: resource, role: "admin"
    sign_in user

    assert_authorized_to :edit?, resource do
      get edit_team_url(resource)
    end

    assert_response :success
    assert_select "form[action='#{team_path(resource)}']"
  end

  def test_put_update_anon
    resource = FactoryBot.create :team

    put team_url(resource), params: {team: {title: "New Title"}}

    assert_redirected_to new_user_session_url
  end

  def test_put_update_non_admin
    user = FactoryBot.create :user
    resource = FactoryBot.create :team, users: [user]
    sign_in user

    put team_url(resource), params: {team: {title: "New Title"}}

    assert_redirected_to root_url
  end

  def test_put_update
    user = FactoryBot.create :user
    resource = FactoryBot.create :team, title: "Gandalf the Grey"
    Membership.create! user: user, team: resource, role: "admin"
    new_title = "Gandalf the White"
    sign_in user

    assert_authorized_to :update?, resource do
      put team_url(resource), params: {team: {title: new_title}}
    end
    
    assert_redirected_to team_url(resource)
    follow_redirect!
    assert_response :success
    assert_equal new_title, resource.reload.title
  end

  def test_delete_destroy_anon
    resource = FactoryBot.create :team

    assert_difference("Team.count", 0) do
      delete team_url(resource)
    end

    assert_redirected_to new_user_session_url
  end

  def test_delete_destroy_non_admin
    user = FactoryBot.create :user
    resource = FactoryBot.create :team, users: [user]
    sign_in user

    assert_difference "Team.count", 0 do
      delete team_url(resource)
    end

    assert_redirected_to root_url
  end

  def test_delete_destroy
    user = FactoryBot.create :user
    resource = FactoryBot.create :team
    Membership.create! user: user, team: resource, role: "admin"
    sign_in user

    assert_difference "Team.count", 0 do
      assert_authorized_to :destroy?, resource, context: {user: user} do
        delete team_url(resource)
      end
    end

    assert resource.reload.deleted_at?

    assert_redirected_to teams_url
    follow_redirect!
    assert_response :success
  end
end
