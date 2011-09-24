module ElasticSearch
  module QueryPlugin
    def search
      @search ||= ElasticSearch::Search::BaseQuery.new
      yield @search if block_given?
      @search
    end
    
    def method_missing(sym, *args, &block)
    
      if search.respond_to?(sym)
        search.query.send(sym, *args, &block)
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