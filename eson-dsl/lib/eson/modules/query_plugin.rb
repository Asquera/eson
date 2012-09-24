module Eson
  module QueryPlugin
    def query
      if block_given?
        @query ||= Eson::Search::BaseQuery.new
        @query.instance_exec(@query, &Proc.new)
      end

      @query
    end

    def call(*args)
      if query.respond_to?(:to_query_hash)
        self.parameters = query.to_query_hash
      end

      super(*args)
    end

    def method_missing(sym, *args, &block)
      if query.query.respond_to?(sym)
        query.query.send(sym, *args, &block)
      else
        super
      end
    end

    def self.plugin_for(protocol)
      [protocol::Search,
       protocol::Count,
       protocol::DeleteByQuery,
       protocol::Percolate,
       protocol::Explain]
    end
    
    def handle_block(&block)
      # in ruby 1.8.7, `lambda {}.arity == -1`
      if (block.arity == 0) || (block.arity == -1)
        query(&block)
      else
        super
      end
    end
  end
end