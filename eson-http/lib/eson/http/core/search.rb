module Eson
  module HTTP
    module Core
      module Search
        include Shared::Core::Search
        extend API

        request_method :post

        def bare_path
          unless types.empty?
            path = "{indices}/{types}/"
          else
            path = "{indices}/"
          end
        end

        def path
          bare_path + "_search"
        end
      end
    end
  end
end