namespace :daily_countable do
  desc "Persist the count of records"
  task :persist_counts => [:environment] do
    DailyCountable.persist_counts
  end
end 
