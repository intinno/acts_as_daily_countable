class ActivePeriod < ActiveRecord::Base

  belongs_to :record, :polymorphic => true 

  named_scope :model_records, lambda { |ids, model_name|
    {:conditions => "record_id in (#{ids.join(",")}) and record_class = '#{model_name}'"}
  }

  def self.set_start(ids, model_name)
    logger.debug "start ids = #{ids.inspect}"
    return if ids.empty?
    model_name.constantize.find(:all, :conditions => "id in (#{ids.join(",")})").each do |record|
      ap_record = ActivePeriod.model_records([record.id], model_name).first
      unless ap_record 
        ActivePeriod.create(
          :start => record.created_at.db_date,
          :record_class => model_name,
          :record_id => record.id)
      else
        ap_record.update_attribute(:start, record.created_at.db_date)
      end
    end
  end

  def self.set_end(ids, model_name)
    return if ids.empty?
    ActivePeriod.model_records(ids, model_name).each do |record|
      record.end = Date.today.db_date
      record.save
    end
  end
end

