class PlotPlantsController < ApplicationController
  def destroy
    @pp = PlotPlant.find(params[:id])
    @plot = pp.plot
    @pp.destroy
    @redirect to plot_path(plot)
  end
end