step 'I access the login page' do
  visit '/login/new'
end

step "I try to login with :name and :password" do |name, password|
  send "I fill in :field with :value", "las.login.label.name", name
  send "I fill in :field with :value", "las.login.label.password", password
  send "I click :label button",        "las.login.button.login"
end

step 'I can see button :skill_profile and :settings on the :name page' do |button_profile, button_settings, name|
  uri  = URI.parse(page.current_url)
  body = Nokogiri::HTML(page.body)
  expect(uri.path).to eq('/welcome')
  [button_profile, button_settings].each { |expected_button| have_button(expected_button) }
  expect(body.title).to eq I18n.t("las.#{name}.show.title")
end
