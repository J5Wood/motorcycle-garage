class CreateMotorcycles < ActiveRecord::Migration[5.2]
  def change
    create_table :motorcycles do |t|
      t.string :name
      t.integer :year
      t.string :color
      t.string :mileage
      t.string :user_id
      t.string :brand_id
    end
  end
end
