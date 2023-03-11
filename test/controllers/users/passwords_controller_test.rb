module Users
  class PasswordsControllerTest < ActionDispatch::IntegrationTest
    def test_get_new
      get new_user_password_url
      assert_response :success
      assert_select "[name='user[email]']", 1
      assert_select "[type=submit]", 1
    end

    def test_post_create
      user = FactoryBot.create :user, email: "gandalf@hotmail.com"

      post user_password_url, params: {
        user: {
          email: user.email
        }
      }

      assert_redirected_to new_user_session_url
      follow_redirect!
      assert_response :success
      assert_select ".alert-info", 1
    end

    def test_post_create_invalid
      FactoryBot.create :user, email: "gandalf@hotmail.com"

      post user_password_url, params: {
        user: {
          email: "wrong@email.com"
        }
      }

      assert_response :unprocessable_entity
      assert_select ".alert-danger", 1
    end

    def test_get_edit
      user = FactoryBot.create :user, email: "gandalf@hotmail.com"
      token  = user.send_reset_password_instructions

      get edit_user_password_url, params: {
        reset_password_token: token
      }

      assert_response :success
      assert_select "[name='user[password]']", 1
      assert_select "[name='user[password_confirmation]']", 1
      assert_select "[type=submit]", 1
    end

    def test_get_edit_invalid
      get edit_user_password_url

      assert_redirected_to new_user_session_url
      follow_redirect!
      assert_response :success
    end

    def test_put_update
      user = FactoryBot.create :user, email: "gandalf@hotmail.com"
      token  = user.send_reset_password_instructions

      put user_password_url, params: {
        user: {
          reset_password_token: token,
          password: "newpassword",
          password_confirmation: "newpassword"
        }
      }

      assert_redirected_to root_url
      follow_redirect!
      assert_response :success
    end

    def test_put_update_invalid
      user = FactoryBot.create :user, email: "gandalf@hotmail.com"
      token  = user.send_reset_password_instructions

      put user_password_url, params: {
        user: {
          reset_password_token: token,
          password: "newpassword",
          password_confirmation: "wrongpassword"
        }
      }

      assert_response :unprocessable_entity
      assert_select "[name='user[password]']", 1
      assert_select "[name='user[password_confirmation]']", 1
      assert_select "[type=submit]", 1
    end
  end
end