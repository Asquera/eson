require 'virtus'

module Eson
  module Transform
    module Api
      class Param
        include Virtus.model

        attribute :type, String
        attribute :description, String
      end
    end
  end
end
