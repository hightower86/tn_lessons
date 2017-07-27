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

module Accessors

  def attr_accessor_with_history(*attrs)
  attrs.each do |attr|
    class_var_name = "@@#{attr}".to_sym
    define_method(attr) { class_variable_get(class_var_name) }
    define_method("#{attr}=".to_sym) { |value| class_variable_set(class_var_name, value) }
    end
  end
end
