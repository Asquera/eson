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

        def render_parts
          parts.map do |k, v|
            "part :#{k}, #{v.render}"
          end
        end

        def parameter_definitions
          params.map { |k, v| v.definition(k) }
        end
      end
    end
  end
end
