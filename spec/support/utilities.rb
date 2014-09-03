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

def invalid_url?(field_under_test, object_under_test)
    address_valid = true
    addresses = ["abc", "www.abc.de"]
    addresses.each do |invalid_address|
      field_under_test = invalid_address
      address_valid = object_under_test.valid?
    end
    return address_valid
end

def valid_url?(field_under_test, object_under_test)
    address_valid = false
    addresses = ["http://www.ard.de/", "https://gmail.com", "http://asdf.com"]
    addresses.each do |valid_address|
      field_under_test = valid_address
      address_valid = object_under_test.valid?
    end
end