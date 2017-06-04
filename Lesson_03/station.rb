class Station 
  attr_reader :station_title
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

  def trains_by_type(tr_type)
    arr = @trains.find_all{ |t| t.type == tr_type } 
    arr.size
  end
end