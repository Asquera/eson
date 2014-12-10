module Eson
  module HTTP
    module Cluster
      module Stats
        include Shared::Cluster::Stats
        extend API

        request_method :get

        def path
          if nodes.empty?
            '/_nodes/stats'
          else
            '/_nodes/{nodes}/stats'
          end
        end
      end
    end
  end
end