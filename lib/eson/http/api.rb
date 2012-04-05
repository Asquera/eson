module Eson
  module HTTP
    module API
      include Eson::API
      
      def request_method(method)
        define_method :request_method do
          @request_method || method
        end
      end
    end
  end
end