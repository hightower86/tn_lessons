class Train

  attr_reader :num_vagons
  attr_accessor :current_station
  attr_accessor :current_route
 
  def initialize(num_tr, type, num_vagons)
    @num_tr = num_tr
    @type = type
    @speed = 0
    @num_vagons = num_vagons
    @current_route = nil
  end

  def take_route(current_route)
    puts current_route.route
    #@current_station = current_route.first
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
      @num_vagons += 1
    end
  end

  def unhook
    if @speed == 0
      if @num_vagons > 0
        @num_vagons -= 1
      end
    end
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
end