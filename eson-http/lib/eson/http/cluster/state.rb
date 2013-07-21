module Eson
  module HTTP
    module Cluster
      module State
        include Shared::Cluster::State
        extend API
        #TODO implement filter_indices correctly

        request_method :get

        def path
          '/_cluster/state'
        end

      end
    end
  end
end