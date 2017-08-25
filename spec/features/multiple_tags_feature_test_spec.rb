require 'spec_helper'
require_relative '../../app/models/link.rb'
require_relative '../../app/app.rb'

RSpec.feature "Visiting /links/tags" do
  scenario "Checking if multiple tags can be tagged to a link" do
    visit '/links'
    click_button("Save a new link")
    fill_in('tags', :with => 'bubbles orange')
    click_button("Save")
    expect(page.status_code).to eq 200

    within 'ul#links' do
      link = Link.first
      expect(link.tags.map(&:name)).to include('bubbles', 'orange')
    end
  end

end
