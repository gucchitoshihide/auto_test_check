step 'The accounts of :table_name registered' do |registered_table|
  FactoryGirl.create(registered_table)
end

step 'I fill in :field with :value' do |field, value|
  fill_in(I18n.t(field), with: value)
end

step 'I click :label button' do |label|
  click_button(I18n.t(label))
end
