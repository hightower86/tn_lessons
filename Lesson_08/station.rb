class Station
  include InstanceCounter

  @@stations = []

  def self.all
    @@stations
  end

  attr_accessor :title

  def initialize(title)
    @title = title
    @trains = []
    @@stations << self
    register_instance
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  def take_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def list_of_trains
    @trains.each { |t| yield t }
  end

  def trains_by_type(tr_type)
    arr = @trains.find_all { |t| t.type == tr_type }
    arr.size
  end

  protected

  def validate!
    raise 'Название станции не может быть пустым!' if title.nil? || title.empty?
    true
  end
end
