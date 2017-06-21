class PassengerVagon
  attr_reader :type

  include Manufacturer

  def initialize(number)
    @type = :passenger
    @number = number
    @manufacturer = call_manufacturer
    register_instance
  end
end