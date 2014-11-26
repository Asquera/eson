module Eson
  module HTTP
    module Cluster
      module Nodes
        include Shared::Cluster::Nodes
        extend API

        request_method :get

        def path
          '/_nodes/{nodes}'
        end
      end
    end
  end
end