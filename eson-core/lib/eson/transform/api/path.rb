require 'virtus'

module Eson
  module Transform
    module Api
      class Path
        include Virtus.model

        attribute :type, Array[String]
        attribute :required, Boolean, default: true
        attribute :description, String, default: ''
      end
    end
  end
end
