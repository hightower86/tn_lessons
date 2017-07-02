class Vagon

  include Manufacturer, InstanceCounter

  attr_reader :type
  attr_accessor :number

  def initialize(number)
    @number = number
    register_instance
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  protected
  def validate!
    raise "Номер не может быть пустым!" if number.nil?
    raise "Номер не может быть короче 3 символов!" if number.length < 3
    true
  end

end