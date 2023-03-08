class RegistrationsControllerTest < ActionDispatch::IntegrationTest

  def test_get_new
    get new_user_registration_url
    assert_response :success
    assert_select "[name='user[email]']", 1
    assert_select "[name='user[password]']", 1
    assert_select "[name='user[password_confirmation]']", 1
    assert_select "[type=submit]", 1
  end

  def test_post_create
    email = "gandalf@hotmail.com"

    assert_difference "User.count", 1 do
      post user_registration_url, params: {
        user: {
          email: email,
          password: "test12345",
          password_confirmation: "test12345"
        }
      }
    end

    assert_equal email, User.order(created_at: :desc).first.email
    assert_redirected_to root_url
    follow_redirect!
    assert_response :success
  end

end