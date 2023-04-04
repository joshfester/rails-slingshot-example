require "test_helper"

class TeamsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in FactoryBot.create(:user)
    @resource = FactoryBot.create :team
  end

  test "should get index" do
    get teams_url
    assert_response :success
  end

  test "should get new" do
    get new_team_url
    assert_response :success
  end

  test "should create team" do
    assert_difference("Team.count") do
      post teams_url, params: { team: {  } }
    end

    assert_redirected_to team_url(Team.last)
  end

  test "should show team" do
    get team_url(@resource)
    assert_response :success
  end

  test "should get edit" do
    get edit_team_url(@resource)
    assert_response :success
  end

  test "should update team" do
    patch team_url(@resource), params: { team: {  } }
    assert_redirected_to team_url(@resource)
  end

  test "should destroy team" do
    assert_difference("Team.count", -1) do
      delete team_url(@resource)
    end

    assert_redirected_to teams_url
  end
end
