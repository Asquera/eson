require 'faraday'

module Eson
  module HTTP
    # This is the HTTP specific subclass of Eson::Request that encodes all
    # HTTP interactions.
    class Request < Eson::Request
      # This middleware circumvents faradays detection of
      # :get as special and emits a generic request - which
      # can have a body...
      # This is mostly due to ElasticSearchs reliance of
      # Bodys on get and delete.
      #
      # @api interal
      class GetHackMiddleware < Faraday::Middleware
        def call(env)
          env[:method] = "get" if env[:method] == :get

          @app.call env
        end
      end

      # Constructs the base resource to send requests to.
      #
      # @api internal
      # @return [Faraday::Connection] the connection
      def base_resource
        conn = Faraday.new(:url => client.node) do |builder|
          builder.use Faraday::Response::Logger, client.logger
          builder.use GetHackMiddleware

          builder.adapter :net_http_persistent
        end

        conn.basic_auth(*client.auth) if client.auth?
        conn
      end

      # Emits a HTTP request based on the parameters and API information.
      #
      # @api internal
      # @return [Faraday::Response] the response
      def call
        resource = base_resource

        response = (
          case request_method
          when :get
            resource.get fill do |req|
              (req.body = source) if source
            end
          when :head
            resource.head fill
          when :delete
            resource.delete(fill) do |req|
              req.body = source if source
            end
          when :post
            resource.post(fill, source)
          when :put
            resource.put(fill, source)
          end
        )
        
        response
      end

      # Fills in the blanks in the path by using {Addressable::Template}.
      #
      # @api internal
      # @return [String] the full uri
      def fill
        template = Addressable::Template.new(path)

        template_keys = template.keys.map(&:to_sym)
        expansions = {}
        query_values = {}

        url_params.each do |p|
          val = self.send(p)

          if template_keys.include? p
            expansions[p] = val if val
          else
            query_values[p] = val if val
          end
        end

        uri = template.expand(expansions)
        uri.query_values = query_values unless query_values.empty?
        uri
      end

      # The parameters that are passed in the url. These are all params
      # without the source params.
      #
      # @return [Array] the url parameters
      def url_params
        if self.respond_to? :source_param
          source_params = Array(source_param)
        else
          source_params = []
        end

        (parameters - source_params)
      end

      # Returns the request method. If none is given, it is assumed to be
      # `:get`.
      #
      # @return [Symbol] The request method.
      def request_method
        @request_method || :get
      end
    end
  end
end