class RemoveTypesFromRoute < ActiveRecord::Migration[5.1]
  def change
    remove_column :routes, :origin
    remove_column :routes, :destination
  end
end
