module Manufacturer
  def call_manufacturer
    puts "Введите наименование производителя"
    manufacturer = gets.chomp
  end

  module InstanceCounter

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.include     InstanceMethods
    end

    module ClassMethods
      @instances = 0
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
end