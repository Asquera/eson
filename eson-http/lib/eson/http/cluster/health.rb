module Eson
  module HTTP
    module Cluster
      module Health
        include Shared::Cluster::Health
        extend API

        request_method :get

        def path
          '/_cluster/health/{indices}'
        end
      end
    end
  end
end