module Eson
  module HTTP
    module SimpleSearch
      include Shared::SimpleSearch
      extend API
      
      request_method :get
      
      def path
        unless types.empty?
          "{-list|,|indices}/{-list|,|types}/_search"
        else
          "{-list|,|indices}/_search"
        end
      end
    end
  end
end