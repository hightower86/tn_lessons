module Manufacturer

  def set_manufacturer(title)
    self.manufacturer = title
  end

  def manufacturer
    self.manufacturer
  end

  protected
  attr_accessor :manufacturer
end

module InstanceCounter

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.include     InstanceMethods
  end

  module ClassMethods
    
    def instances
      @instances
    end

    def counter_up
      if @instances == nil
        @instances = 0
      end
      @instances += 1
    end
  end

  module InstanceMethods
    protected
    def register_instance
      self.class.send :counter_up
    end
  end
end
