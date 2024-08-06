class PlantPlotsController < ApplicationController
  def destroy
    plant_plot = PlantPlot.find(params[:id])
    plant = plant_plot.plant
    plant.destroy
    redirect_to plots_path
  end
end