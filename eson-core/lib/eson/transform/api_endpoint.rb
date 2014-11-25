require 'virtus'

module Eson
  module Transform
    class ApiEndpoint
      include Virtus.model

      attribute :name, String, default: ''
      attribute :documentation, String, default: ''
      attribute :request_methods, Array[String], default: []
      attribute :url, Eson::Transform::Api::Url
      attribute :body, Hash, default: {}

      def request_methods
        @request_methods.map { |m| ":#{m.to_s.downcase}" }.join(', ')
      end

      def get_binding
        binding
      end

      def top_level_name
        names = @name.split('.')
        result = names.shift(names.size - 1)
        result.empty? ? '' : result.first.capitalize
      end

      def module_name
        names = @name.split('.')
        names.shift(names.size - 1)
        names.empty? ? '' : names.first.capitalize
      end
    end
  end
end
