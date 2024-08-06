class RenamePlotPlantsColumns < ActiveRecord::Migration[7.1]
  def change
    rename_column :plot_plants, :plots_id, :plot_id
    rename_column :plot_plants, :plants_id, :plant_id
  end
end
