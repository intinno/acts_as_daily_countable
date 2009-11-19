class Date
  def db_date
    self.strftime("%Y-%m-%d")
  end
end

class Time
  def db_date
    self.strftime("%Y-%m-%d")
  end
end
