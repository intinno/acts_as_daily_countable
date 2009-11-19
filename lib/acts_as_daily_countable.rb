module ActsAsDailyCountable
  def self.included(base)
    base.extend ClassMethods
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
  end

end

ActiveRecord::Base.send(:include, ActsAsDailyCountable)
