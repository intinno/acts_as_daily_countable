class CreateActivePeriods < ActiveRecord::Migration
  def self.up
    create_table :active_periods do |t|
      t.date :start
      t.date :end
      t.integer :record_id
      t.string :record_class

      t.timestamps
    end
  end

  def self.down
    drop_table :active_periods
  end
end
