require_relative "modules"
require_relative 'validation'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  attr_reader :current_speed, :vagons, :current_station,
              :current_route, :type, :manufacturer
  attr_accessor :num_tr

  @@trains = {}

  NUMBER_FORMAT = /\A[А-Яа-я0-9]{3}-*[А-Яа-я0-9]{2}\z/

  validate :num_tr, :presence
  validate :num_tr, :format, NUMBER_FORMAT
  
  def initialize(num_tr, type)
    @num_tr = num_tr
    @type = type
    @current_speed = 0
    @vagons = []
    @@trains[num_tr] = self
    register_instance
    validate!
  end

  def self.find(number)
    @@trains[number]
  end

  def valid?
    validate!
  rescue
    false
  end

  def take_route(route)
    @current_route = route
    @current_station = current_route.route.first
    @current_station.take_train(self)
  end

  def speed_up
    @current_speed += 10
  end

  def brake
    @current_speed = 0
  end

  def hook(vagon)
    raise 'Тип вагона не соответствует типу поезда!' if vagon.type != @type
    @vagons << vagon
  end

  def unhook(vagon)
    @vagons.delete(vagon) if current_speed.zero? && !vagons.empty?
  end

  def move_back
    if current_station != current_route.route.first
      ind_cs = current_route.index current_station
      @current_station = current_route.route[ind_cs - 1]
    else
      puts "Станция #{@current_station} является отправной.
            Поезд не может двигаться назад"
    end
  end

  def move_forward
    if current_station != current_route.route.last
      ind_cs = current_route.route.index current_station
      @current_station = current_route.route[ind_cs + 1]
    else
      puts "Станция #{@current_station} является конечной.
            Поезд не может двигаться вперед"
    end
  end

  def list_of_vagons
    vagons.each { |v| yield v }
  end

  protected

  # def validate!
  #   raise 'Номер не может быть пустым!' if num_tr.nil?
  #   raise 'Номер не может быть короче 5 символов!' if num_tr.length < 5
  #   raise 'Номер поезда не соответствует формату!' if num_tr !~ NUMBER_FORMAT
  #   true
  # end
end
