module Eson
  module HTTP
    # HTTP::Api is like {Eson::Api}, but allows to define a request method
    # as well. All HTTP::Api objects also have to define `#path` as a method
    # to return the endpoint path as a url template.
    module API
      include Eson::API

      # DSL method to indicate the request method.
      #
      # @param [symbol] method The http method verb to use.
      def request_method(method)
        define_method :request_method do
          @request_method || method
        end
      end
    end
  end
end