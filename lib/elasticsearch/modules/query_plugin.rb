module ElasticSearch
  module QueryPlugin
    def query
      @query ||= ElasticSearch::Search::BaseQuery.new
      yield @query if block_given?
      @query
    end
    
    def call(*args)
      if query.respond_to? :to_query_hash
        self.params = query.to_query_hash
      end
      
      super(*args)
    end
    
    def method_missing(sym, *args, &block)
      if query.query.respond_to? sym
        query.query.send(sym, *args, &block)
      else
        super
      end
    end
    
    def self.plugin_for(protocol)
      [protocol::Search,
       protocol::Count]
    end
  end
end