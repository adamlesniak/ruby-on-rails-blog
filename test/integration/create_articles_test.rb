require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest
  
  
  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end
  
  
  test "get new article form and create article" do
    sign_in_as(@user, 'password')
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: {description: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem", title: "Test article"}
    end
    assert_template 'articles/show'
    assert_select 'div.alert-success'
  end
  
    
  test "invalid article format results in failure" do
    sign_in_as(@user, 'password')
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do
      post_via_redirect articles_path, article: {description: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.", title: "Test article"}
    end
    assert_template 'articles/new'
    assert_select 'h2.panel-title'
    assert_select 'ul.errors'
  end
  
end