And /the following articles exist/ do |articles_table|
  articles_table.hashes.each do |article|
    Article.create!(article)
  end
end

And /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create!(user)
  end
end

And /the following comments exist/ do |comments_table|
  comments_table.hashes.each do |comment|
    Comment.create!(comment)
  end
end

Given /I am logged in as "(.*)" with the password "(.*)"/ do |user, password|
  visit '/accounts/login'
  fill_in 'user_login', :with => user
  fill_in 'user_password', :with => password
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end

Given /the article with id "(.*)" has been merged with article with id "(.*)"/ do |id1, id2|
  article = Article.find_by_id(id1)
  article.merge_with(id2)
end

Then /the article with id "(.*)" should have body "(.*)"/ do |id, body|
  article = Article.find_by_id(id)
  assert article.body == body
end

Then /the article with id "(.*)" should have author "(.*)" or "(.*)"/ do |id, author1, author2|
  article = Article.find_by_id(id)
  assert(article.author = author1 || article.author = author2)
end

Then /the article with id "(.*)" should have title "(.*)" or "(.*)"/ do |id, title1, title2|
  article = Article.find_by_id(id)
  assert(article.title == title1 || article.title = title2)
end
