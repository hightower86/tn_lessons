require_relative 'validation'
require_relative 'modules'

class Station
  include InstanceCounter, Validation

  @@stations = []

  def self.all
    @@stations
  end

  attr_accessor :title

  validate :title, :presence

  def initialize(title)
    validate!
    @title = title
    @trains = []
    @@stations << self
    register_instance
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
end
