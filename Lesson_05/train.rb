
class Train

  @@trains = {}
  
  def self.find(number)
    @@trains[number]
  end

  include Manufacturer
  include InstanceCounter

  attr_reader :current_speed, :vagons, :current_station, :current_route, :num_tr, :type, :manufacturer

  def initialize(num_tr, type)
    @num_tr = num_tr
    @type = type
    @current_speed = 0
    @vagons = []
    @manufacturer = call_manufacturer
    @@trains[num_tr] = self
    register_instance
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
    if vagon.type == @type
      @vagons << vagon
    else
      puts "Ошибка типа вагона!"
    end

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
end


