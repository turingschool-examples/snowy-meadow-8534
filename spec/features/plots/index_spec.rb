require "rails_helper"

RSpec.describe "Plots Index Page" do
  before :each do

  end
  context "User Story #1" do
    it "displays the names of all plants under their plot numbers" do
      
      # When I visit the plots index page ('/plots')
      visit plots_path
      
      # I see a list of all plot numbers
      within "#plots" do
      @garden.plots.each do |plot|
        within "#plot_id-#{plot.id}" do
        expect(page).to have_content(plot.number)
        
        # And under each plot number I see the names of all that plot's plants
        expect(page).to have_content(plot.plants.name)
        end
      end
    end
  end
end