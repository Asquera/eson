require 'virtus'

module Eson
  module Transform
    module Api
      class Param
        include Virtus.model

        attribute :type, String
        attribute :options, Array[String], default: []
        attribute :default, String, default: nil
        attribute :description, String, default: ''

        def definition(name)
          case type
          when 'boolean', 'string', 'time', 'number'
            "parameter_#{type} :#{name.to_s}"
          when 'enum'
            "parameter_#{type} :#{name.to_s}, #{options}, #{default_value}"
          else
            raise ArgumentError, "unsupported type #{type} found"
          end
        end

        def default_value
          default ? "\"#{default}\"" : "nil"
        end
      end
    end
  end
end
