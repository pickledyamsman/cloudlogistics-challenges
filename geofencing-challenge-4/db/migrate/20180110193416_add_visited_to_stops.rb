class AddVisitedToStops < ActiveRecord::Migration[5.1]
  def change
    add_column :stops, :visited, :boolean, default: false
  end
end
