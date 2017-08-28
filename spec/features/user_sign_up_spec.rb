require 'spec_helper'
# require_relative '../../app/models/link.rb'
require_relative '../../app/app.rb'
require_relative '../web_helper.rb'

RSpec.feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, eli@example.com')
    expect(User.first.email).to eq('eli@example.com')
  end
end
