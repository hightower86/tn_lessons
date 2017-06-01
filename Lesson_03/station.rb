class Station 

  def initialize(station_title)
    @station_title = station_title
    @trains = []
  end

  def take_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def get_train_list
    @trains.each { |t| puts t }
  end

  def get_num_tr_type(tr_type)

    arr = @trains.find_all{ |t| t.type == tr_type } 
    @num_tr_type = arr.size
  end
end