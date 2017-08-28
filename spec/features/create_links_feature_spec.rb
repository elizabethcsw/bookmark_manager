require 'spec_helper'
require_relative '../../app/models/link.rb'
require_relative '../../app/app.rb'

RSpec.feature "creating links" do
  scenario "create links on the links page" do
    visit '/links'
    click_button("Save a new link")
    fill_in('title', :with => 'first_title')
    fill_in('url', :with => 'http://www.makersacademy.com')
    click_button("Save")
    # Link.create(url: 'http://www.makersacademy.com', title: "Makers")
    # visit '/links/new'

    expect(page.status_code).to eq 200

    within 'ul#links' do
      expect(page).to have_content("first_title")
      # link = Link.first(title: "first_title")
      # link.destroy
    end
  end

end
