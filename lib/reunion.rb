class Reunion
  attr_reader :name, :activities

  def initialize(name)
    @name       = name
    @activities = Array.new
  end

  def add_activity(activity)
    @activities.push(activity)
  end

  def total_cost
    @activities.reduce(0) do |sum, activity|
      sum += activity.total_cost
      sum
    end
  end

  def breakdown 
    @activities.reduce({}) do |hash, activity| 
      activity.calculate_amount_owed.keys.each do |participant| 
        if hash.include?(participant)
          hash[participant] += activity.calculate_amount_owed[participant]
        else 
          hash.store(participant, activity.calculate_amount_owed[participant])
        end
      end
      hash
    end
  end

  def print_tab_summary
    breakdown.keys.reduce('') {|string, p| string += "#{p} owes #{breakdown[p]} "}
  end
end