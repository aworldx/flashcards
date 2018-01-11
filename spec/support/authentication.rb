module AuthenticationForFeatureRequest
  def login (user, password = 'vrdffpswrd')
    user.update_attributes password: password

    page.driver.post user_sessions_path, { user: { email: user.email, password: password } }
    visit root_url
  end
end
