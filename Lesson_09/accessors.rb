module Accessors
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def attr_accessor_with_history(*attrs)
      attrs.each do |attr|
        var_name = "@#{attr}".to_sym
        define_method(attr) { instance_variable_get(var_name) }
        define_method("#{attr}=".to_sym) do |value| 
          instance_variable_set(var_name, value) 
          @history ||= {}
          @history[attr] ||= []
          @history[attr] << value
        end
        define_method("#{attr}_history") {@history[attr]}
      end
    end
    def strong_attr_accessor(name, type)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value| 
        raise TypeError, "Ошибка типа!!!" unless value.class.is_a?(type)
        instance_variable_set(var_name, value)  
      end
    end
  end
end
