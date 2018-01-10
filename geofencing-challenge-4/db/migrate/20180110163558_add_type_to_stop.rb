class AddTypeToStop < ActiveRecord::Migration[5.1]
  def change
    add_column :stops, :stop_type, :string
  end
end
