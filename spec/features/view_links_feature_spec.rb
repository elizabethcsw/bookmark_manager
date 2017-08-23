require 'spec_helper'
require_relative '../../app/models/link.rb'
require_relative '../../app/app.rb'


RSpec.feature "viewing links" do
  scenario "view links on the links page" do
    Link.create(url: 'http://www.makersacademy.com', title: "Makers")
    visit '/links'
    expect(page.status_code).to eq 200

    within 'ul#links' do
      expect(page).to have_text("Makers")
      # link = Link.first(title: "Makers")
      # link.destroy
    end

  end
end
