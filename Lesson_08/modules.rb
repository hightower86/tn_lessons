module Manufacturer
  attr_accessor :manufacturer
end

module InstanceCounter
  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.include InstanceMethods
  end

  module ClassMethods
    def instances
      @instances
    end

    def counter_up
      @instances ||= 0
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
