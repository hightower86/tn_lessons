class Station 

  @@stations = []

  def self.all
    @@stations
  end

  attr_reader :title

  def initialize(title)
    @title = title
    @trains = []
    @@stations << self
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