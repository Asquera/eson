module Eson
  module HTTP
    module Core
      module Update
        include Shared::Core::Update
        extend API

        request_method :post

        def path
          "/{index}/{type}/{id}/_update"
        end
      end
    end
  end
end