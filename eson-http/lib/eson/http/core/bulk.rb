module Eson
  module HTTP
    module Core
      module Bulk
        FIELD_MAPPING = [:index, :type, :id, :parent, :ttl, :timestamp, :routing].map do |field|
          [field, "_#{field}"]
        end

        include Shared::Core::Bulk
        extend API

        request_method :put

        def path
          '/_bulk'
        end

        def source
          bulk.map {|r| serialize_request(r)}.join
        end

        def serialize_request(request)
          case request
          when Eson::HTTP::Core::Index
            MultiJson.encode({ "index" => to_params_hash(request) }) << "\n" << request.source << "\n"
          when Eson::HTTP::Core::Delete
            MultiJson.encode({ "delete" => to_params_hash(request) }) << "\n"
          else
            warn("Unserializable request #{request.inspect}")
          end
        end

        def to_params_hash(r)
          FIELD_MAPPING.inject({}) do |params, (field, serialized_field)|
            if r.respond_to?(field) && val = r.send(field)
              params[serialized_field] = val
            end
            params
          end
        end
      end
    end
  end
end