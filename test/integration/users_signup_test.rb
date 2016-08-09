require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
 test "invalid signup form information" do
   get signup_path
    assert_no_difference 'User.count' do
      assert_select 'form[action="/signup"]'
      post signup_path, params: { user: { name: "",
                                          email: "invalid@example",
                                          password: "foo",
                                          password_confirmation: "bar"
      }}
    end
    assert_template 'users/new'
    assert_select "div#error_explanation"
    assert_select "div.alert-danger"
 end

test "valid signup form information" do
 get signup_path
 assert_difference 'User.count', 1 do
  post users_path, params: { user: { name: "Example User",
                                     email: "user@example.com",
                                     password: "password",
                                     password_confirmation: "password"} }
  end
  follow_redirect!
  assert_template 'users/show'
  assert_select 'div.alert'
  assert is_logged_in?
 end
end