# require_relative "modules"

class Train

  include Manufacturer
  include InstanceCounter

  attr_reader :current_speed, :vagons, :current_station, :current_route, :type, :manufacturer
  attr_accessor :num_tr

  @@trains = {}

  NUMBER_FORMAT = /\A[А-Яа-я0-9]{3}-*[А-Яа-я0-9]{2}\z/

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
  end

  def speed_up
    @current_speed += 10
  end

  def brake
    @current_speed = 0
  end

  def hook(vagon)
    raise "Ошибка! Тип вагона не соответствует типу поезда!" if vagon.type != @type
    @vagons << vagon
  end

  def unhook(vagon)
    if current_speed == 0 && vagons.size > 0
      @vagons.delete(vagon)
    end
  end

  def move_back
    if current_station != current_route.route.first
      ind_cs = current_route.index current_station
      @current_station = current_route.route[ind_cs - 1]
    else
      puts "Станция #{@current_station} является отправной. Поезд не может двигаться назад"
    end
  end

  def move_forward
    if current_station != current_route.route.last
      ind_cs = current_route.route.index current_station
      @current_station = current_route.route[ind_cs + 1]
    else
      puts "Станция #{@current_station} является конечной. Поезд не может двигаться вперед"
    end
  end
  
  protected

  def validate!
    raise "Номер не может быть пустым!" if num_tr.nil?
    raise "Номер не может быть короче 5 символов!" if num_tr.length < 5
    raise "Номер поезда не соответствует формату!" if num_tr !~ NUMBER_FORMAT
    true
  end
end


