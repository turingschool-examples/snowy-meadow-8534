require "rails_helper"

RSpec.describe "Plots Index Page" do
  before :each do
    @garden_1 = Garden.create!(name: "Mean Green", organic: true)
    @plot_1 = Plot.create!(number: 1, size: "Large", direction: "North", garden: @garden_1)
    @plot_2 = Plot.create!(number: 2, size: "Small", direction: "South", garden: @garden_1)
    @plot_3 = Plot.create!(number: 3, size: "Medium", direction: "East", garden: @garden_1)
    @plot_4 = Plot.create!(number: 4, size: "Extra Medium", direction: "West", garden: @garden_1)
    @plant_1 = Plant.create!(name: "Tomatoes", description: "Black Krim", days_to_harvest: 65)
    @plant_2 = Plant.create!(name: "Tomatoes", description: "Cherokee Pink", days_to_harvest: 65)
    @plant_3 = Plant.create!(name: "Tomatoes", description: "Sun Gold", days_to_harvest: 70)
    @plant_4 = Plant.create!(name: "Chiles", description: "Jalapeños", days_to_harvest: 85)
    @plant_5 = Plant.create!(name: "Chiles", description: "Thai Hot", days_to_harvest: 90)
    @plant_6 = Plant.create!(name: "Watermellon", description: "Golden Sweet", days_to_harvest: 110)
    @plant_7 = Plant.create!(name: "Corn", description: "Blood Red", days_to_harvest: 80)
    PlantPlot.create!(plant: @plant_1, plot: @plot_1)
    PlantPlot.create!(plant: @plant_2, plot: @plot_1)
    PlantPlot.create!(plant: @plant_3, plot: @plot_1)
    PlantPlot.create!(plant: @plant_4, plot: @plot_2)
    PlantPlot.create!(plant: @plant_5, plot: @plot_2)
    PlantPlot.create!(plant: @plant_6, plot: @plot_3)
    PlantPlot.create!(plant: @plant_7, plot: @plot_4)
  end
  context "User Story #1" do
    it "displays the names of all plants under their plot numbers" do
      
      # When I visit the plots index page ('/plots')
      visit plots_path
      
      # I see a list of all plot numbers
      within "#plots" do
        @plots.each do |plot|
          within "#plot_id-#{plot.id}" do
          expect(page).to have_content(plot.number)
          
          # And under each plot number I see the names of all that plot's plants
          expect(page).to have_content(plot.plants.name)
          end
        end
      end
    end
  end
end