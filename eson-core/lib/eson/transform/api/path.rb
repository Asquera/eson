require 'virtus'

module Eson
  module Transform
    module Api
      class Path
        include Virtus.model

        attribute :type, Array[String]
        attribute :required, Boolean
        attribute :description, String, default: ''

        def render
          temp = (type.size == 1) ? 'String' : 'Array[String]'
          result  = "type: #{temp}"
          result += ", required: #{required}" unless required.nil?
          result
        end
      end
    end
  end
end
