require 'virtus'

module Eson
  module Transform
    module Api
      class Url
        include Virtus.model

        attribute :path, String
        attribute :paths, Array[String], default: []
        attribute :parts, Hash[String => Path], default: {}
        attribute :params, Hash[String => Param]
      end
    end
  end
end
