module Eson
  module HTTP
    module IndexExists
      include Shared::IndexExists
      extend API
      
      request_method :head
      
      def path
        "/{indices}"
      end 
    end
  end
end