require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  setup do
    @main_title = "| RoR App"
  end

  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Home #{@main_title}"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help #{@main_title}"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About #{@main_title}"
  end
end
