class ChangeUserNameToUsername < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.rename :name, :username
    end
  end
end
