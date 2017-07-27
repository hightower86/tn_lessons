require_relative 'validation'
require_relative 'modules'
require_relative 'station'


class Route
  include InstanceCounter, Validation

  attr_reader :route
  # attr_accessor :start_station, :end_station

  validate :start_station, :presence, Station
  validate :end_station, :type, Station

  def initialize(start_station, end_station)
    # @start_station = start_station
    # @end_station = end_station
    validate!
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
