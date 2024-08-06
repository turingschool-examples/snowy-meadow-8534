require 'rails_helper'

RSpec.describe "Plots Index Page" do
  before :each do
    @garden = Garden.create!(name: "Fart Garden", organic: true)

    @plot_1 = Plot.create!(number: 1, size: "small", direction: "N", garden_id: @garden.id)
    @plot_2 = Plot.create!(number: 2, size: "medium", direction: "S", garden_id: @garden.id)
    @plot_3 = Plot.create!(number: 3, size: "large", direction: "E", garden_id: @garden.id)
    @plot_4 = Plot.create!(number: 4, size: "xl", direction: "W", garden_id: @garden.id)

    @plant_1 = Plant.create!(name: "dog", description: "goes 'woof'", days_to_harvest: 60)
    @plant_2 = Plant.create!(name: "cat", description: "goes 'meow'", days_to_harvest: 50)
    @plant_3 = Plant.create!(name: "fish", description: "goes 'fissssshhhhh'", days_to_harvest: 40)
    @plant_4 = Plant.create!(name: "gerbil", description: "goes 'squeek'", days_to_harvest: 20)
    @plant_5 = Plant.create!(name: "t-rex", description: "goes 'rawr'", days_to_harvest: 365)

    @pp1 = PlotPlant.create!(plot_id: @plot_1.id, plant_id: @plant_4.id)
    @pp2 = PlotPlant.create!(plot_id: @plot_1.id, plant_id: @plant_3.id)
    @pp3 = PlotPlant.create!(plot_id: @plot_1.id, plant_id: @plant_1.id)
    @pp4 = PlotPlant.create!(plot_id: @plot_2.id, plant_id: @plant_3.id)
    @pp5 = PlotPlant.create!(plot_id: @plot_2.id, plant_id: @plant_1.id)
    @pp6 = PlotPlant.create!(plot_id: @plot_3.id, plant_id: @plant_2.id)
    @pp7 = PlotPlant.create!(plot_id: @plot_3.id, plant_id: @plant_4.id)
    @pp8 = PlotPlant.create!(plot_id: @plot_4.id, plant_id: @plant_5.id)
    
  end

  context "As a visitor" do
    describe "When I visit the plots index page ('/plots')" do
      it "I see a list of all plot numbers" do
        visit plots_path
        within "#plots" do
          expect(page).to have_content("Plot Number #{@plot_1.number}")
          expect(page).to have_content("Plot Number #{@plot_2.number}")
          expect(page).to have_content("Plot Number #{@plot_3.number}")
          expect(page).to have_content("Plot Number #{@plot_4.number}")
        end
      end
      it "and under each plot number I see the names of all that plot's plants" do
        visit plots_path
        # save_and_open_page
        within "#plots" do
          within "#plot_plants-#{@plot_1.id}" do
            expect(page).to have_content(@plant_3.name)
            expect(page).to have_content(@plant_1.name)
            expect(page).to have_content(@plant_4.name)
            expect(page).to_not have_content(@plant_2.name)
            expect(page).to_not have_content(@plant_5.name)
          end

          within "#plot_plants-#{@plot_2.id}" do
            expect(page).to have_content(@plant_3.name)
            expect(page).to have_content(@plant_1.name)
            expect(page).to_not have_content(@plant_4.name)
            expect(page).to_not have_content(@plant_2.name)
            expect(page).to_not have_content(@plant_5.name)
          end

          within "#plot_plants-#{@plot_3.id}" do
            expect(page).to have_content(@plant_4.name)
            expect(page).to have_content(@plant_2.name)
            expect(page).to_not have_content(@plant_1.name)
            expect(page).to_not have_content(@plant_3.name)
            expect(page).to_not have_content(@plant_5.name)
          end

          within "#plot_plants-#{@plot_4.id}" do
            expect(page).to have_content(@plant_5.name)
            expect(page).to_not have_content(@plant_2.name)
            expect(page).to_not have_content(@plant_1.name)
            expect(page).to_not have_content(@plant_2.name)
            expect(page).to_not have_content(@plant_4.name)
          end
        end
      end

      it "Next to each plant's name I see a button to Remove that plant from that plot," do
        it "Then next to each experiment's name, I see a button to remove that experiment from that scientist's work load" do
          visit plots_path
  
          within "plots" do
            within "#plot_plants-#{@plot_1.id}" do
              expect(page).to have_button("Remove #{@plant_3.name}")
              expect(page).to have_button("Remove #{@plant_1.name}")
              expect(page).to have_button("Remove #{@plant_4.name}")
            end
            within "#plot_plants-#{@plot_2.id}"  do
              expect(page).to have_button("Remove #@plant_3.name}")
              expect(page).to have_button("Remove #@plant_1.name}")
            end
            within "#plot_plants-#{@plot_3.id}" do
              expect(page).to have_button("Remove #{@plant_4.name}")
              expect(page).to have_button("Remove #{@plant_2.name}")
            end
            within "#plot_plants-#{@plot_4.id}" do
              expect(page).to have_button("Remove #{@plant5.name}")
            end
          end
        end
      end
    end
  end
end