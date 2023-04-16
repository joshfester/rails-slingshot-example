require "test_helper"

module Users
  class RegistrationsControllerTest < ActionDispatch::IntegrationTest
    def test_get_new
      get new_user_registration_url
      assert_response :success
      assert_select "form#new_user [name='user[email]']", 1
      assert_select "form#new_user [name='user[password]']", 1
      assert_select "form#new_user [name='user[password_confirmation]']", 1
      assert_select "form#new_user [type=submit]", 1
    end

    def test_post_create
      email = "gandalf@hotmail.com"

      assert_difference -> { Team.count } => 1, -> { User.count } => 1 do
        post user_registration_url, params: {
          user: {
            email: email,
            password: "test12345",
            password_confirmation: "test12345"
          }
        }
      end

      user = User.find_by email: email

      assert user.personal_team.present?
      assert_equal 1, user.owned_teams.count
      assert_redirected_to root_url
      follow_redirect!
      assert_response :success
    end

    def test_post_create_invalid
      assert_no_difference "User.count" do
        post user_registration_url, params: {
          user: {
            email: "gandalf@hotmail.com",
            password: "test12345",
            password_confirmation: "nope"
          }
        }
      end

      assert_response :unprocessable_entity
      assert_select ".alert-danger", 1
    end
  end
end
