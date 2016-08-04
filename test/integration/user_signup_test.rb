require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  
 
  test "get new userform and valid sign up" do
    get sign_up_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {username: "someuser", email: "valid@example.com", password: "password"}
    end
    assert_template 'users/show'
    assert_match "someuser", response.body
  end
   
   
  test "get new userform and invalid sign up" do
    get sign_up_path
    assert_template 'users/new'
    assert_no_difference 'User.count' do
      post_via_redirect users_path, user: {username: "' OR", email: "validasasdasd.com", password: "'''"}
    end
    assert_template 'users/new'
    assert_select 'h2.panel-title'
    assert_select 'ul.errors'
  end
  
end
