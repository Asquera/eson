module Eson
  module HTTP
    module Indices
      module GetMapping
        include Shared::Indices::GetMapping
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
end