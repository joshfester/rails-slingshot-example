require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def test_get_home_anon
    get root_url
    assert_response :success
  end

  def test_get_home_reader
    sign_in FactoryBot.build :user, role: :reader
    get root_url
    assert_response :success
  end

  def test_get_home_editor
    sign_in FactoryBot.build :user, role: :editor
    get root_url
    assert_response :success
  end

  def test_get_home_admin
    sign_in FactoryBot.build :user, role: :admin
    get root_url
    assert_response :success
  end
end
