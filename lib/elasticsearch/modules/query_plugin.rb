module ElasticSearch
  module QueryPlugin
    def query
      if block_given?
        @query ||= ElasticSearch::Search::BaseQuery.new
        yield @query if block_given?
        @query
      end
      
      @query
    end
    
    def call(*args)
      if query.respond_to? :to_query_hash
        query.to_query_hash.each do |k,v|
          self.send("#{k}=", v)
        end
      end
      
      super(*args)
    end
    
    def self.plugin_for(protocol)
      [protocol::Search,
       protocol::Count]
    end
  end
end