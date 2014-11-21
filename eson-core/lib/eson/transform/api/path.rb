require 'virtus'

module Eson
  module Transform
    module Api
      class Path
        include Virtus.model

        attribute :type, Array[String]
        attribute :required, Boolean, default: true
        attribute :description, String, default: ''

        def render
          temp = (type.size == 1) ? 'String' : 'Array[String]'
          "type: #{temp}, required: #{required}"
        end
      end
    end
  end
end
