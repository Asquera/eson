module ElasticSearch
  class Client
    attr_accessor :server
    attr_accessor :index_name
    attr_accessor :default_index
    attr_accessor :protocol
    attr_accessor :plugins  
    attr_accessor :opts
    
    DEFAULT_OPTS = {
                      :server => 'http://127.0.0.1:9200',
                      :plugins => [],
                      :logger => nil,
                      :default_index => "default"
                   }
    
    # TODO: allow multiple servers and pick them at random
    def initialize(opts = {})
      opts = DEFAULT_OPTS.merge(opts)
      
      self.server        = opts[:server]
      self.default_index = opts[:default_index]
      self.protocol      = opts[:protocol] || ElasticSearch::HTTP
      self.plugins       = opts[:plugins]
      self.logger        = opts[:logger]
      self.opts          = opts
    end
    
    def node
      self.server
    end
    
    def logger=(logger)
      protocol.logger = logger
    end
    
    def logger(logger)
      protocol.logger
    end
    
    def index_name
      @index_name || default_index
    end
    
    def [](index_name)
      c = self.clone
      c.index_name = index_name
      c
    end
    
    def index(args = {})
      request(protocol::Index, args)
    end
    
    def delete(args = {})
      request(protocol::Delete, args)
    end
    
    def get(args = {})
      request(protocol::Get, args)
    end
    
    def search(args = {}, immediate = true, &block)
      request(protocol::Search, args, immediate, &block)
    end
    alias :query :search
    
    def simple_search(args = {})
      request(protocol::SimpleSearch, args)
    end
    
    def count(args = {})
      request(protocol::Count, args)
    end
    
    def percolate(args = {})
      request(protocol::Percolate, args)
    end
    
    def bulk(args = {})
      request(protocol::Bulk, args)
    end
    
    def delete_by_query(args = {})
      request(protocol::DeleteByQuery, args)
    end
    
    def more_like_this(args = {})
      request(protocol::MoreLikeThis, args)
    end
    
    def health(args = {})
      request(protocol::Health, args, true)
    end
    
    def state(args = {})
      request(protocol::State, args, true)
    end
    
    def stats(args = {})
      request(protocol::Stats, args, true)
    end
    
    def nodes(args = {})
      request(protocol::Nodes, args, true)
    end
    
    def shutdown(args = {})
      request(protocol::Shutdown, args, true)
    end
    
    def aliases(args = {}, &block)
      request(protocol::Aliases, args, true, &block)
    end
    
    def analyze(args = {})
      request(protocol::Analyze, args)
    end
    
    def clear_cache(args = {})
      request(protocol::ClearCache, args, true)
    end
    
    def close_index(args = {})
      request(protocol::CloseIndex, args, true)
    end
    
    def open_index(args = {})
      request(protocol::OpenIndex, args, true)
    end
    
    def create_index(args = {})
      request(protocol::CreateIndex, args)
    end
    
    def delete_index(args = {})
      request(protocol::DeleteIndex, args, true)
    end
    
    def delete_mapping(args = {})
      request(protocol::DeleteMapping, args, true)
    end
    
    def get_mapping(args = {})
      request(protocol::GetMapping, args, true)
    end
    
    def put_mapping(args = {})
      request(protocol::PutMapping, args, true)
    end
    
    def put_template(args = {})
      request(protocol::PutTemplate, args, true)
    end
    
    def get_template(args = {})
      request(protocol::GetTemplate, args, true)
    end
    
    def delete_template(args = {})
      request(protocol::DeleteTemplate, args, true)
    end
    
    def get_settings(args = {})
      request(protocol::GetSettings, args, true)
    end
    
    def update_settings(args = {})
      request(protocol::UpdateSettings, args, true)
    end
    
    def flush(args = {})
      request(protocol::Flush, args, true)
    end
    
    def optimize(args = {})
      request(protocol::Optimize, args, true)
    end
    
    def refresh(args = {})
      request(protocol::Refresh, args, true)
    end
    
    def snapshot(args = {})
      request(protocol::Snapshot, args, true)
    end
    
    def status(args = {})
      request(protocol::Status, args, true)
    end
    
    private
      def request(endpoint, args, auto_call = false)
        r = protocol::Request.new(endpoint, plugins, self)
        
        if args != {}
          args.each do |k,v|
            r.send :"#{k}=", v
          end
          
          if block_given?
            yield r
          end
          
          r.call
        else
          if block_given?
            yield r
          end
          
          if auto_call
            r.call
          else
            r
          end
        end
        
      end
  end
end