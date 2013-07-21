module Eson
  module HTTP
    module Core
      module DeleteByQuery
        extend API
        include Shared::Core::DeleteByQuery

        request_method :delete

        def bare_path
          unless types.empty?
            path = "{indices}/{types}/"
          else
            path = "{indices}/"
          end
        end

        def path
          bare_path + "_query"
        end
      end
    end
  end
end