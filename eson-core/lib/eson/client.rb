module Eson
  class Client
    attr_accessor :server
    attr_accessor :index_name
    attr_accessor :default_parameters
    attr_accessor :protocol
    attr_accessor :plugins
    attr_accessor :opts
    attr_accessor :auto_call
    
    DEFAULT_OPTS = {
                      :server => 'http://127.0.0.1:9200',
                      :plugins => [],
                      :logger => nil,
                      :default_parameters => { :index => "default" }
                   }
    
    # TODO: allow multiple servers and pick them at random
    def initialize(opts = {})
      opts = DEFAULT_OPTS.merge(opts)
      self.opts          = opts
      opts = opts.clone

      self.server        = opts.delete(:server)
      default_index      = opts.delete(:default_index)
      self.protocol      = opts.delete(:protocol) || Eson::HTTP
      self.plugins       = opts.delete(:plugins)
      self.logger        = opts.delete(:logger)
      self.auto_call     = opts.delete(:auto_call)

      self.default_parameters = opts.delete(:default_parameters) || {}

      if default_index
        default_parameters[:index] ||= default_parameters
      end

      if self.auto_call.nil?
        self.auto_call = true
      end
    end
    
    # @deprecated
    def default_index=(index_name)
      default_index[:index] = index_name
    end
    
    def with(params = {})
      client = self.clone
      client.default_parameters = default_parameters.merge(params)
      yield client
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
    
    def auth?
      !!opts[:auth]
    end
    
    def auth
      opts[:auth]
    end
    
    def index_name
      @index_name
    end
    
    def [](index_name)
      c = self.clone
      c.index_name = index_name
      c
    end
    
    def index(args = {}, immediate = auto_call)
      request(protocol::Index, args, immediate)
    end
    
    def delete(args = {}, immediate = auto_call)
      request(protocol::Delete, args, immediate)
    end
    
    def get(args = {})
      request(protocol::Get, args)
    end
    
    def mget(args = {})
      request(protocol::MultiGet, args)
    end
    
    def search(args = {}, immediate = auto_call, &block)
      request(protocol::Search, args, immediate, &block)
    end
    alias :query :search
    
    def scroll(args = {})
      request(protocol::Scroll, args)
    end
    
    def simple_search(args = {})
      request(protocol::SimpleSearch, args)
    end
    
    def count(args = {})
      request(protocol::Count, args)
    end
    
    def update(args = {})
      request(protocol::Update, args)
    end
    
    def percolate(args = {}, &block)
      request(protocol::Percolate, args, &block)
    end
    
    def bulk(args = {}, &block)
      if block_given?
        request(protocol::Bulk, args, &block)
      else
        request(protocol::Bulk, args, false)
      end
    end
    
    def msearch(args = {}, &block)
      if block_given?
        request(protocol::MultiSearch, args, &block)
      else
        request(protocol::MultiSearch, args, false)
      end
    end
    
    def delete_by_query(args = {}, &block)
      request(protocol::DeleteByQuery, args, &block)
    end
    
    def more_like_this(args = {})
      request(protocol::MoreLikeThis, args)
    end
    
    def health(args = {})
      request(protocol::Health, args)
    end
    
    def state(args = {})
      request(protocol::State, args)
    end
    
    def stats(args = {})
      request(protocol::Stats, args)
    end
    
    def nodes(args = {})
      request(protocol::Nodes, args)
    end
    
    def shutdown(args = {})
      request(protocol::Shutdown, args)
    end
    
    def aliases(args = {}, &block)
      request(protocol::Aliases, args, &block)
    end
    
    def analyze(args = {})
      request(protocol::Analyze, args)
    end
    
    def clear_cache(args = {})
      request(protocol::ClearCache, args)
    end
    
    def close_index(args = {})
      request(protocol::CloseIndex, args)
    end
    
    def open_index(args = {})
      request(protocol::OpenIndex, args)
    end
    
    def create_index(args = {})
      request(protocol::CreateIndex, args)
    end
    
    def delete_index(args = {})
      request(protocol::DeleteIndex, args)
    end
    
    def delete_mapping(args = {})
      request(protocol::DeleteMapping, args)
    end
    
    def get_mapping(args = {})
      request(protocol::GetMapping, args)
    end
    
    def put_mapping(args = {})
      request(protocol::PutMapping, args)
    end
    
    def put_template(args = {})
      request(protocol::PutTemplate, args)
    end
    
    def get_template(args = {})
      request(protocol::GetTemplate, args)
    end
    
    def delete_template(args = {})
      request(protocol::DeleteTemplate, args)
    end
    
    def get_settings(args = {})
      request(protocol::GetSettings, args)
    end
    
    def update_settings(args = {})
      request(protocol::UpdateSettings, args)
    end
    
    def flush(args = {})
      request(protocol::Flush, args)
    end
    
    def optimize(args = {})
      request(protocol::Optimize, args)
    end
    
    def refresh(args = {})
      request(protocol::Refresh, args)
    end
    
    def snapshot(args = {})
      request(protocol::Snapshot, args)
    end
    
    def status(args = {})
      request(protocol::Status, args)
    end
    
    def index_stats(args = {})
      request(protocol::IndexStats, args)
    end
    
    def segments(args = {})
      request(protocol::Segments, args)
    end
    
    def exists?(args = {})
      request(protocol::IndexExists, args)
    rescue Eson::NotFoundError
      false
    end
    
    private
      def request(endpoint, args, auto_call = auto_call)
        r = protocol::Request.new(endpoint, plugins, self)
        
        r.parameters = default_parameters.merge(args)
        
        if block_given?
          r.handle_block(&Proc.new)
        end
        
        if auto_call
          r.call
        else
          r
        end
      end
  end
end