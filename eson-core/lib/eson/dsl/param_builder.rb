require 'virtus'

module Eson
  module API
    module DSL
      class ParamBuilder
        def initialize(&block)
          instance_eval(&block) if block_given?
        end

        def enum(name, enum_values = [], default = nil)
          in_module do
            attribute name.to_sym, String, default: default, coercer: proc { |value|
              unless enum_values.include?(value) || value.nil?
                raise ArgumentError
              end
              value
            }
          end
        end

        def string(name, default = nil)
          in_module do
            attribute name.to_sym, String, default: default
          end
        end

        def boolean(name, default = nil)
          in_module do
            attribute name.to_sym, 'Boolean', default: default
          end
        end

        def numnber(name, default = nil)
          in_module do
            attribute name.to_sym, Fixnum, default: default
          end
        end

        private

        def in_module(&block)
          mod = Module.new do
            include Virtus.module
            instance_eval(&block) if block_given?
          end
          extend mod
        end
      end
    end
  end
end
