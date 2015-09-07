class AddDayToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :day, :string
  end
end
