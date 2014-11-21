module Eson
  module API
    module ParameterMethods
      def parameter_string(name)
        attribute name.to_sym, String
      end

      def parameter_boolean(name)
        attribute name.to_sym, 'Boolean'
      end

      def parameter_time(name)
        attribute name.to_sym, DateTime
      end

      def parameter_number(name)
        attribute name.to_sym, Fixnum
      end

      def parameter_enum(name, enum_values = [], default = nil)
        mod = Module.new do
          include Virtus.module
          attribute name.to_sym, String, default: default, coercer: proc { |value|
            unless enum_values.include?(value) || value.nil?
              raise ArgumentError
            end
            value
          }
        end
        self.include(mod)
      end
    end
  end
end
