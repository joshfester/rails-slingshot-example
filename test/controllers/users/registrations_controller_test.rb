require "test_helper"

module Users
  class RegistrationsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

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

    def test_get_edit_anon
      get edit_user_registration_url
      assert_redirected_to new_user_session_url
      follow_redirect!
      assert_response :success
    end

    def test_get_edit
      sign_in FactoryBot.create :user
      get edit_user_registration_url
      assert_response :success

      assert_select "form#edit_user", 1 do
        assert_select "[name='user[email]']", 1
        assert_select "[name='user[password]']", 1
        assert_select "[name='user[password_confirmation]']", 1
        assert_select "[name='user[current_password]']", 1
        assert_select "[type=submit]", 1
      end
    end

    def test_put_update_invalid
      sign_in FactoryBot.create :user

      put user_registration_url, params: {
        user: {
          password: "test12345",
          password_confirmation: "nope"
        }
      }

      assert_response :unprocessable_entity
      assert_select ".alert-danger", 1
    end

    def test_put_update
      password = "test12345678"

      user = FactoryBot.create :user, 
        email: "gandalf_grey@middleearth.net",
        password: password

      sign_in user
      old_encrypted_password = user.encrypted_password
      email = "gandalf_white@middleearth.net"

      put user_registration_url, params: {
        user: {
          email: email,
          password: "test12345",
          password_confirmation: "test12345",
          current_password: password
        }
      }

      assert_redirected_to root_url
      follow_redirect!
      assert_response :success
      assert_select ".alert", 1
      assert_select ".alert-danger", 0
      assert_equal email, user.reload.email
      assert_not_equal old_encrypted_password, user.encrypted_password
    end

  end
end
