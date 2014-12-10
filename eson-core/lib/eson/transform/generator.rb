require 'erb'
require 'json'

module Eson
  module Transform
    class Generator
      attr_reader :api_endpoint

      def initialize(hash)
        @api_endpoint = Eson::Transform::ApiEndpoint.new(hash)
      end

      def description
        convert('description.erb')
      end

      def request
        convert('request.erb')
      end

      private

        def convert(template)
          root = File.dirname(__FILE__)
          template = File.read(File.join(root, 'templates', template))
          ERB.new(template).result(api_endpoint.get_binding)
        end
    end
  end
end
