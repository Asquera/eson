module Eson
  module HTTP
    module Cluster
      module Nodes
        include Shared::Cluster::Nodes
        extend API

        request_method :get

        def path
          '/_cluster/nodes/{nodes}'
        end
      end
    end
  end
end