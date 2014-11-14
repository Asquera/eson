require 'virtus'

module Eson
  module Transform
    module Api
      class Path
        include Virtus.model

        attribute :type, String
        attribute :required, Boolean
        attribute :description, String, default: ''
      end
    end
  end
end
