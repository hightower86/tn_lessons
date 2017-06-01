class Train
  def initialize(num_tr, type, num_vag)
    @num_tr = num_tr
    @num_vag = num_vag
    @type = type
    @speed = 0

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

  def get_num_vags
    @num_vag
  end

  def hook
    if @speed = 0
      @num_vag += 1
    end
  end

  def unhook
    if @speed = 0
      if @num_vag > 1
        @num_vag -= 1
      else 
        @num_vag = 0
      end
    end
  end

  def take_route(route)
    @route = Route.new(start_station, end_station)
    @current_station = @route.first
  end

  def move_back
    if current_station != @route.first
      ind_cs = @route.index @current_station
      @current_station = @route[ind_cs - 1]
    else
      puts "Станция #{@current_station} является отправной. Поезд не может двигаться назад"
    end
  end

  def move_forward
    if current_station != @route.last
      ind_cs = @route.index @current_station
      @current_station = @route[ind_cs + 1]
    else
      puts "Станция #{@current_station} является конечной. Поезд не может двигаться вперед"
    end
  end

  def current_station
    @current_station
  end

end