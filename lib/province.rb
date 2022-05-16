require_relative 'producer'

class Province

  attr_reader :name
  attr_accessor :total_production, :demand, :price

  def initialize(doc)
    @name = doc[:name]
    @producers = []
    @total_production = 0
    @demand = doc[:demand]
    @price = doc[:price]
    doc[:producers].each { |d| add_producer(Producer.new(self, d)) }
  end

  def add_producer(arg)
    @producers << arg
    @total_production += arg.production
  end

  def producers
    @producers.dup # Returning a copy prevents mutation of @producers.
  end

  def shortfall
    @demand = 10 if @demand == ''
    @demand - @total_production
  end

  def profit
    demand_value - demand_cost
  end

  def demand_cost
    remaining_demand = @demand
    result = 0
    @producers.sort_by(&:cost).each do |p|
      contribution = [remaining_demand, p.production].min
      remaining_demand -= contribution
      result += contribution * p.cost
    end
    result
  end

  def demand_value
    satisfied_demand * @price
  end

  def satisfied_demand
    [@demand, @total_production].min
  end

end
