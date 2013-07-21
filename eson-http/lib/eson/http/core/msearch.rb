module Eson
  module HTTP
    module Core
      module MultiSearch
        include Shared::Core::MultiSearch
        extend API

        request_method :post

        def path
          '/_msearch'
        end

        def source
          msearch.map {|r| serialize_request(r)}.join
        end

        def serialize_request(request)
          case request
          when Eson::HTTP::Core::Search
            MultiJson.encode(to_params_hash(request)) << "\n" << request.source << "\n"
          else
            warn("Unserializable request #{request.inspect}")
          end
        end

        def to_params_hash(r)
          r.url_params.inject({}) do |h, p|
            val = r.send(p)
            if val
              h[p] = val unless val.respond_to?(:empty?) && val.empty?
            end
            h
          end
        end

        def path
          unless types.empty?
            path = "{indices}/{types}/"
          else
            path = "{indices}/"
          end

          path << "_msearch"
        end
      end
    end
  end
end