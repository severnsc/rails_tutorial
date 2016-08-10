require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  
  def setup
    @user = users(:michael)
    remember(@user)
  end
  
  test "current user returns right when session is nil" do
    assert_equal current_user, @user
    assert is_logged_in?
  end
  
  test "current user returns nil when session is wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end