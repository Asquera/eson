module Eson
  module HTTP
    module Cluster
      module Shutdown
        #TODO fully implement and test this
        include Shared::Cluster::Shutdown
        extend API

        request_method :post

        def path
          '/_cluster/nodes/{nodes}/_shutdown'
        end
      end
    end
  end
end