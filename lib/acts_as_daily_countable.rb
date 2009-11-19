module ActsAsDailyCountable
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do 
      include InstanceMethods
    end
  end

  module ClassMethods
    def acts_as_daily_countable
      registered_models = DailyCountable.models
      registered_models.blank? ?
        DailyCountable.models = [self.to_s] :
        DailyCountable.models += [self.to_s] 
    end

    def daily_countables
      self.find(:all)
    end

    def count_on(date)
      return nil unless date.is_a?(Date)
      DailyCountable.model_entry_on(self.to_s, date).try(:count)
    end

    def ids_on(date)
      return nil unless date.is_a?(Date)
      DailyCountable.model_entry_on(self.to_s, date).try(:ids)
    end
  end

  module InstanceMethods
    def active_periods
      periods = ActivePeriod.find(:all, :conditions => "record_class = '#{self.class.to_s}' and record_id = #{self.id}")
      periods.collect{|p| [p.start, p.end]}
    end
  end

end

ActiveRecord::Base.send(:include, ActsAsDailyCountable)
