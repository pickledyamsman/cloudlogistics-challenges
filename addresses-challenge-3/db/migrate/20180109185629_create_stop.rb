class CreateStop < ActiveRecord::Migration[5.1]
  def change
    create_table :stops do |t|
      t.string :address
      t.integer :route_id
    end
  end
end
