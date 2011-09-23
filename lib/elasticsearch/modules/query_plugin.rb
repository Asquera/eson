module ElasticSearch
  module QueryPlugin
    def query
      @query ||= ElasticSearch::Search::BaseQuery.new
      yield @query if block_given?
      @query
    end
    
    def method_missing(sym, *args, &block)
      if query.respond_to?(sym)
        query.send(sym, *args, &block)
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