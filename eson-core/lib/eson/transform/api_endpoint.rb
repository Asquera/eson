module Eson
  module Transform
    class ApiEndpoint
      attr_reader :top_level_name, :module_name
      attr_reader :documentation

      def initialize(hash)
        @name, @root  = hash.first
        @documenation = @root.fetch('documentation')
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
