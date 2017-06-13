class Train

  attr_reader :current_speed, :vagons, :current_station, :current_route, :num_tr, :type
  attr_writer :current_speed, :vagons, :current_station, :current_route

   
  def initialize(num_tr, type)
    @num_tr = num_tr
    @type = type
    @current_speed = 0
    @vagons = []
    @current_route = nil
  end

  def take_route(route)
    self.current_route = route
    self.current_station = current_route.route.first
  end

  def speed_up
    self.current_speed += 10
  end

  def brake
    self.current_speed = 0
  end

  def hook(vagon)
    if vagon.type == @type
      self.vagons << vagon
    else
      puts "Ошибка типа вагона!"
    end

  end

  def unhook
    if current_speed == 0 && vagons.size == 0
      self.vagons.pop
    end
  end

  def move_back
    if current_station != current_route.route.first
      ind_cs = current_route.index current_station
      self.current_station = current_route.route[ind_cs - 1]
    else
      puts "Станция #{@current_station} является отправной. Поезд не может двигаться назад"
    end
  end

  def move_forward
    if current_station != current_route.route.last
      ind_cs = current_route.route.index current_station
      self.current_station = current_route.route[ind_cs + 1]
    else
      puts "Станция #{@current_station} является конечной. Поезд не может двигаться вперед"
    end
  end
end


