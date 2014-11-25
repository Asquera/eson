require 'virtus'

module Eson
  module Transform
    module Api
      class Param
        include Virtus.model

        attribute :type, String, default: 'string'
        attribute :options, Array[String], default: []
        attribute :default, String, default: nil
        attribute :description, String, default: ''

        def definition(name)
          case type
          when 'boolean', 'string', 'text', 'time', 'number', 'duration', 'list'
            "#{type} :#{name.to_s}"
          when 'enum'
            "#{type} :#{name.to_s}, #{options}, #{render_value}"
          else
            raise ArgumentError, "Unsupported type #{type} found"
          end
        end

        def render_value
          if default.is_a?(Array)
            "#{default}"
          else
            default.nil? ? "nil" : "\"#{default}\""
          end
        end
      end
    end
  end
end
