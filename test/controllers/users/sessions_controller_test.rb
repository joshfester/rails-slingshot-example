require "test_helper"

module Users
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    def test_get_new
      get new_user_session_url
      assert_response :success
      assert_select "form#new_user [name='user[email]']", 1
      assert_select "form#new_user [name='user[password]']", 1
      assert_select "form#new_user [type=submit]", 1
    end

    def test_post_create
      user = FactoryBot.create :user, email: "gandalf@hotmail.com", password: "password"

      post user_session_url, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }

      assert_redirected_to root_url
      follow_redirect!
      assert_response :success
      assert_select ".alert-info", 1
    end

    def test_post_create_invalid
      user = FactoryBot.create :user, email: "gandalf@hotmail.com", password: "password"

      post user_session_url, params: {
        user: {
          email: user.email,
          password: "wrong"
        }
      }

      assert_response :unprocessable_entity
      assert_select ".alert-info", 1
    end
  end
end
