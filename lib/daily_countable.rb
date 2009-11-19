class DailyCountable < ActiveRecord::Base
  mattr_accessor :models

  def self.persist_counts
    models.each do |model_name|
      model = model_name.constantize
      record_ids = model.daily_countables.collect{|r| r.id}
      previous_ids = self.previous_entry_ids(model_name).collect{|p| p.to_i}

      DailyCountable.add_entry=[model_name, record_ids.join(",")]
      ActivePeriod.set_start(record_ids - previous_ids, model_name)
      ActivePeriod.set_end(previous_ids - record_ids, model_name)
    end
  end

  def self.add_entry=(options)
    today = Date.today.db_date
    self.create(:model_name => options[0], :ids => options[1], 
                :counted_on => today, :count => options[1].split(",").size)
  end

  def self.previous_entry_ids(model_name)
    entry = self.find(:last, :conditions =>  " model_name = '#{model_name}' ")
    entry.try(:ids).try(:split, ",") || []
  end

  def self.model_entry_on(model_name, date)
    DailyCountable.find(:last,
      :conditions => "model_name = '#{model_name}' and counted_on = '#{date.db_date}'")
  end
end

