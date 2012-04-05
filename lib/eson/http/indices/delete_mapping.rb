module Eson
  module HTTP
    module DeleteMapping
      include Shared::DeleteMapping
      extend API
      
      request_method :delete
      
      
      def path
        if type && !indices.empty?
          "/{-list|,|indices}/{type}"        
        end
      end
    end
  end
end