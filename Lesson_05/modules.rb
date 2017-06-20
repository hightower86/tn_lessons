module Manufacturer
  def call_manufacturer
    puts "Введите наименование производителя"
    manufacturer = gets.chomp
  end
end

module InstanceCounter

  module ClassMethods
    @instances = 0
    def instances
      @instances
    end

    def counter_up
      @instances += 1
    end
  end
  
  module InstanceMethods
    def register_instance
      self.class.counter_up
    end
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end