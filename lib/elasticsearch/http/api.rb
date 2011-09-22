module ElasticSearch
  module HTTP
    module API
      include ElasticSearch::API
      
      def request_method(method)
        define_method :request_method do
          @request_method || method
        end
      end
    end
  end
end