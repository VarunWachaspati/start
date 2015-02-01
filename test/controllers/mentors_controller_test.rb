require 'test_helper'

class MentorsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get profile" do
    get :profile
    assert_response :success
  end

  test "should get following" do
    get :following
    assert_response :success
  end

  test "should get all" do
    get :all
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get updatepwd" do
    get :updatepwd
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

end
