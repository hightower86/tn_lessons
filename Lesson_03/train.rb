class Train

  
  attr_accessor :current_station, :current_route, :num_vagons
  
  def initialize(num_tr, type, num_vagons)
    @num_tr = num_tr
    @type = type
    @speed = 0
    @num_vagons = num_vagons
    #@current_route = nil
  end

  def take_route(route)
    self.current_route = route
    self.current_station = current_route.route.first
  end

  def speed_up
    @speed += 10
  end

  def current_speed
    @speed
  end

  def brake
    @speed = 0
  end

  def hook
    if @speed == 0
      self.num_vagons += 1
    end
  end

  def unhook
    if @speed == 0
      if num_vagons > 0
        self.num_vagons -= 1
      end
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