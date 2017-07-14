class CargoTrain < Train
  def initialize
    @type = :cargo
    register_instance
  end
end
