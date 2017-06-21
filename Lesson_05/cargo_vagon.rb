class CargoVagon
  attr_reader :type

  include Manufacturer

  def initialize(number)
    @type = :cargo
    @number = number
    register_instance
  end
end