module ElasticSearch
  module HTTP
    module State
      include Shared::State
      extend API
      #TODO implement filter_indices correctly
      
      request_method :get
             
      def path
        '/_cluster/state'
      end
      
    end
  end
end