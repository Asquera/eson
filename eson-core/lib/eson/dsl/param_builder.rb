require 'virtus'

module Eson
  module API
    module DSL
      class ParamBuilder
        def initialize(&block)
          instance_eval(&block) if block_given?
        end

        def enum(name, enum_values = [], default = nil)
          mod = Module.new do
            include Virtus.module
            attribute name.to_sym, String, default: default, coercer: proc { |value|
              unless enum_values.include?(value) || value.nil?
                raise ArgumentError
              end
              value
            }
          end
          extend mod
        end

        def string(name, default = nil)
          mod = Module.new do
            include Virtus.module
            attribute name.to_sym, String, default: default
          end
          extend mod
        end
      end
    end
  end
end
