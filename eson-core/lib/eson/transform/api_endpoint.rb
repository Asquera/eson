require 'virtus'

module Eson
  module Transform
    class ApiEndpoint
      include Virtus.model

      attribute :name, String, default: ''
      attribute :documentation, String, default: ''
      attribute :methods, Array[String], default: ''
      attribute :url, Eson::Transform::Api::Url
      attribute :body, Hash, default: {}

      def parameters
        url.params.keys.map{ |k| ":#{k}" }.join(', ')
      end

      def get_binding
        binding
      end

      def top_level_name
        @name.split('.').first.capitalize
      end

      def module_name
        @name.split('.').last.capitalize
      end
    end
  end
end
