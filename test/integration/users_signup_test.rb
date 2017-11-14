require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "no valid sign up information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "", 
                               email: "user@invalid",
                               password: "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'users/new'
  end
  
  test "valid sign up information with account activation" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: {
                                    name: "User name",
                                    email: "user@ex.com",
                                    password: "password",
                                    password_confirmation: "password" }
    end

    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # Попытаться выполнить вход до активации
    log_in_as(user)
    assert_not is_logged_in?
    # Недопустимый токен активации
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    # Допустимый токен, неверный адрес электронной почты
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Допустимый токен
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
