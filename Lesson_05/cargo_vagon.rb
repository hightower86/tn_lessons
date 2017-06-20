class CargoVagon
  attr_reader :type

  include Manufacturer

  def initialize(number)
    @type = :cargo
    @number = number
    @manufacturer = call_manufacturer
  end
end