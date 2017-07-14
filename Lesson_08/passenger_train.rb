class PassengerTrain < Train
  def initialize
    @type = :passenger
    register_instance
  end
end
