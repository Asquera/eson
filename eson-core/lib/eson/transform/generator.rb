require 'erb'
require 'json'

require 'parser/current'
require 'unparser'

module Eson
  module Transform
    class Generator
      attr_reader :api_endpoint

      def initialize(hash)
        @api_endpoint = Eson::Transform::ApiEndpoint.new(hash)
      end

      def description
        content = convert('description.erb')

        # Check if there are no Ruby errors
        node = Parser::CurrentRuby.parse(content)
        Unparser.unparse(node)

        content
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
