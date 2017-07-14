class PassengerVagon < Vagon
  attr_reader :total_of_places, :taken_seats, :free_seats

  def initialize(number, total_of_places)
    @number = number
    @type = :passenger
    @total_of_places = total_of_places
    @free_seats = total_of_places
    @taken_seats = 0
  end

  def take_seat
    self.taken_seats += 1
    self.free_seats = total_of_places - self.taken_seats

    raise 'Свободных мест в вагоне нет!' if taken_seats > total_of_places
  end

  protected

  attr_writer :taken_seats, :free_seats
end
