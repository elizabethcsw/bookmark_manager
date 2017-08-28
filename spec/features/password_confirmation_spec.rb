require 'spec_helper'
require_relative '../../app/app.rb'
require_relative '../web_helper.rb'

RSpec.feature 'Password confirmation' do
  scenario 'when second password does not match' do
    expect{ sign_up(password2: 'wrong') }.to_not change(User, :count)
    # expect{false_sign_up}.not_to change(User, :count)
    expect(current_path).to eq('/users') # current_path is a helper provided by Capybara
    expect(page).to have_content 'Password does not match the confirmation'
  end

end
