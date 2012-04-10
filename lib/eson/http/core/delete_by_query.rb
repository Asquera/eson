module Eson
  module HTTP
    module DeleteByQuery
      extend API
      include Shared::DeleteByQuery

      request_method :delete

      def bare_path
        unless types.empty?
          path = "{-list|,|indices}/{-list|,|types}/"
        else
          path = "{-list|,|indices}/"
        end
      end

      def path
        bare_path + "_query"
      end
    end
  end
end