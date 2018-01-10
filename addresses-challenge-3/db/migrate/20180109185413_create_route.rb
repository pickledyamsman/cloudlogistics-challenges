class CreateRoute < ActiveRecord::Migration[5.1]
  def change
    create_table :routes do |t|
      t.string :carrier
      t.string :destination
      t.string :origin
    end
  end
end
