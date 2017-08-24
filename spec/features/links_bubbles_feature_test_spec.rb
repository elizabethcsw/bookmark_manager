require 'spec_helper'
require_relative '../../app/models/link.rb'
require_relative '../../app/app.rb'

RSpec.feature "Visiting /links/bubbles" do
  scenario "Checking if links tagged with bubbles are present" do
    visit '/links/bubbles'
    fill_in('tags', :with => 'bubbles')
    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).to have_content("bubbles")
    end
  end

end
