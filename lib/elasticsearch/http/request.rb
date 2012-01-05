require 'faraday'

module ElasticSearch
  module HTTP
    class Request < ElasticSearch::Request
      attr_accessor :request_method
      
      def base_resource
        conn = Faraday.new(:url => client.node) do |builder|
          builder.use Faraday::Response::Logger, ElasticSearch::HTTP.logger
          
          builder.adapter :typhoeus
        end
        
        conn.basic_auth(*client.auth) if client.auth?
        conn
      end
      
      def call
        resource = base_resource

        response = (
          case request_method
          when :get
            resource.get fill
          when :delete
            #resource.options[:payload] = source if source
            resource.delete fill
          when :post
            resource.post(fill, source)
          when :put
            resource.put(fill, source)
          end
        )
      end
      
      def fill
        template = Addressable::Template.new(path)
        
        template_keys = template.keys.map(&:to_sym)
        expansions = {}
        query_values = {}
        
        if self.respond_to? :source_param
          source_params = Array(source_param)
        else
          source_params = []
        end
        
        (parameters - source_params).each do |p|
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
      
      def request_method
        @request_method || :get
      end
    end
  end
end