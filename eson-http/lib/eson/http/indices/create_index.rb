module Eson
  module HTTP
    module Indices
      module CreateIndex
        include Shared::Indices::CreateIndex
        extend API

        request_method :put

        def path
          '/{index}'
        end
      end
    end
  end
end