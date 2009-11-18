module DailyCountable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_daily_countable
      registered_models = DailyCountableModels.names 
      registered_models.blank? ?
        DailyCountableModels.names = [self.to_s] :
        DailyCountableModels.names += [self.to_s] 
    end
  end
end

module DailyCountableModels
  mattr_accessor :names
end

ActiveRecord::Base.send(:include, DailyCountable)
