class PassengerVagon

  include Manufacturer
  
  attr_reader :type

  def initialize(number)
    @type = :passenger
    @number = number
    register_instance
  end
end