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
    @plant_8 = Plant.create!(name: "Eggplant", description: "Japanese Striped", days_to_harvest: 55)
    @plant_X = Plant.create!(name: "Weeds", description: "Nobody Likes You", days_to_harvest: 0)
    PlantPlot.create!(plant: @plant_1, plot: @plot_1)
    PlantPlot.create!(plant: @plant_2, plot: @plot_1)
    PlantPlot.create!(plant: @plant_3, plot: @plot_1)
    PlantPlot.create!(plant: @plant_2, plot: @plot_2)
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
      within("#plot-#{@plot_1.id}") do
        expect(page).to have_content(@plot_1.number)
        expect(page).to have_content(@plant_1.name)
        expect(page).to have_content(@plant_2.name)
        expect(page).to have_content(@plant_3.name)
        expect(page).to_not have_content(@plant_X.name)
      end

      within("#plot-#{@plot_2.id}") do
        expect(page).to have_content(@plot_2.number)
        expect(page).to have_content(@plant_2.name)
        expect(page).to have_content(@plant_4.name)
        expect(page).to have_content(@plant_5.name)
        expect(page).to_not have_content(@plant_X.name)
      end

      within("#plot-#{@plot_3.id}") do
        expect(page).to have_content(@plot_3.number)
        expect(page).to have_content(@plant_6.name)
        expect(page).to_not have_content(@plant_X.name)
      end

      within("#plot-#{@plot_4.id}") do
        expect(page).to have_content(@plot_4.number)
        expect(page).to have_content(@plant_7.name)
        expect(page).to_not have_content(@plant_X.name)
      end
    end
  end

  context "User Story #2" do
    it "removes a plant from a plot" do

      # When I visit the plots index page
      visit plots_path
      save_and_open_page

      # Next to each plant's name
      # I see a button to remove that plant from that plot
        # Pretty sure this can be simplified with an enumerable
        # Maybe later
      within("#plot-#{@plot_1.id}") do
        within("#plant-#{@plant_1.id}") do
          expect(page).to have_button("Remove Plant")
        end
        within("#plant-#{@plant_2.id}") do
          expect(page).to have_button("Remove Plant")
        end
        within("#plant-#{@plant_3.id}") do
          expect(page).to have_button("Remove Plant")
        end
      end

      # When I click on that button
        # Should only click button for `@plant_2`
      within("#plot-#{@plot_1.id}") do
        within("#plant-#{@plant_2.id}") do
          click_button
        end
      end
      
      # I'm returned to the plots index page
      expect(current_path).to eq(plots_path)

      # And I no longer see that plant listed under that plot,
      within("#plot-#{@plot_1.id}") do
        expect(page).to_not have_content(@plant_2.name)
      end

      # And I still see that plant's name under other plots that is was associated with.
      within("#plot-#{@plot_2.id}") do
        expect(page).to have_content(@plot_2.number)
        expect(page).to have_content(@plant_2.name)
        expect(page).to have_content(@plant_4.name)
        expect(page).to have_content(@plant_5.name)
        expect(page).to_not have_content(@plant_X.name)
      end
    end
  end
end