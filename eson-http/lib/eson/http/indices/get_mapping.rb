module Eson
  module HTTP
    module GetMapping
      include Shared::GetMapping
      extend API
      
      request_method :get
      
      def path
        if !types.empty? && !indices.empty?
          "/{indices}/{types}/_mapping"
        elsif !indices.empty?
          "/{indices}/_mapping"
        else
          "/_mapping"
        end
      end
    end
  end
end