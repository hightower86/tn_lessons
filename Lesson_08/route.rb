class Route
  include InstanceCounter

  attr_reader :route

  def initialize(start_station, end_station)
    @route = [start_station, end_station]
    register_instance
  end

  def title
    "#{route.first.title} - #{route.pop.title}"
  end

  def add_station(station)
    @route.insert(-2, station)
  end

  def del_station(station)
    raise "Станции #{station} нет в маршруте!" unless @route.include?(station)
    @route.delete(station)
  end

  def station_list
    @route.each { |e| puts e }
  end
end
