require 'spec_helper'
require_relative '../../app/models/link.rb'
require_relative '../../app/models/tag.rb'
require_relative '../../app/app.rb'

RSpec.feature "tagging links" do
  scenario "tagging links on the links page" do
    visit '/links'
    click_button("Save a new link")
    fill_in('title', :with => 'first_title')
    fill_in('url', :with => 'http://www.google.com')
    fill_in('tags', :with => 'any_tag')
    click_button("Save")

    expect(page.status_code).to eq 200

    within 'ul#links' do
      link = Link.first
    expect(link.tags.map(&:name)).to include('any_tag')
      # expect(page).to have_content("any_tag")
    end
  end

end
