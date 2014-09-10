include ApplicationHelper

def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
  else
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end

def only_urls_are_accepted(field_under_test, object_under_test)
    only_urls_valid = true
    other = ["abc", "www.abc.de"]
    urls = ["http://www.ard.de/", "https://gmail.com", "http://asdf.com", "http://asdf.com/asdfddcd?&$f"]
    
    other.each do |invalid_value|
      field_under_test.replace invalid_value
      only_urls_valid = object_under_test.invalid?
    end
    
    urls.each do |valid_value|
      field_under_test.replace valid_value
      only_urls_valid = object_under_test.valid?
    end
    return only_urls_valid
end