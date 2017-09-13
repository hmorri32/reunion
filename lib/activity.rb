class Activity
  attr_reader :name, 
              :participants, 
              :total_cost

  def initialize(name)
    @name         = name
    @participants = Hash.new
    @total_cost   = 0
  end

  def add_participant(name, amount)
    @participants.store(name, amount)
    @total_cost += amount
  end

  def split
    @total_cost / @participants.keys.length
  end

  def calculate_amount_owed 
    @participants.keys.reduce({}) do |hash, name|
      hash.store(name, split - @participants[name])
      hash
    end
  end
end