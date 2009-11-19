class CreateDailyCountables < ActiveRecord::Migration
  def self.up
    create_table :daily_countables do |t|
      t.date :counted_on
      t.string :model_name
      t.integer :count
      t.text :ids

      t.timestamps
    end
  end

  def self.down
    drop_table :daily_countables
  end
end
