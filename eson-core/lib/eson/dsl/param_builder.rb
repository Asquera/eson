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
              values = Array(value)
              unless values.all?{ |v| enum_values.include?(v) } || value.nil?
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

        alias :text :string

        def list(name, default = nil)
          in_module do
            attribute name.to_sym, Array[String], default: default
          end
        end

        def boolean(name, default = nil)
          in_module do
            attribute name.to_sym, 'Boolean', default: default
          end
        end

        def number(name, default = nil)
          in_module do
            attribute name.to_sym, Fixnum, default: default
          end
        end

        def duration(name, default = nil)
          in_module do
            attribute name.to_sym, Integer, default: default
          end
        end

        def time(name, default = nil)
          in_module do
            attribute name.to_sym, DateTime, default: default
          end
        end

        private

        def in_module(&block)
          @mod ||= Module.new do
            include Virtus.module
          end
          @mod.instance_eval(&block) if block_given?
          extend @mod
        end
      end
    end
  end
end
