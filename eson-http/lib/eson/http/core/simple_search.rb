module Eson
  module HTTP
    module Core
      module SimpleSearch
        include Shared::Core::SimpleSearch
        extend API

        request_method :get

        def path
          unless types.empty?
            "{indices}/{types}/_search"
          else
            "{indices}/_search"
          end
        end
      end
    end
  end
end