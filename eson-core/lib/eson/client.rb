# @!macro request
#   Creates a $0 request.
#   @api requests

# @!macro immediate
#   @overload
#     With a block given, this will return a result.
#     @return [Object] result
#   @overload
#     Without immediate, this will method returns an request object.
#     @return [Eson::API] the request
#   @param [true,false] immediate Whether to immediately call the request or not.

module Eson
  # Eson::Client is a protocol-agnostic client to elasticsearch. For an example
  # of a protocol implementation, see {Eson::HTTP}. The client primarily 
  # constructs {Eson::Request} objects. In default mode, it also calls the
  # backend immediately. This behaviour can be controlled using the parameter
  # `auto_call`.
  #
  # The client (like most parts of Eson) holds no state and can be reused. All
  # operations that change parameters return a new Client object.
  #
  # By default, the client returns the backend response as a raw
  # backend response, unless a set of plugins is specified.
  #
  # It is recommendable to use protocol-specific subclasses like
  # {Eson::HTTP::Client} because they set sane defaults for the plugin-set and
  # return better consumable data.
  #
  # @example Constructing an HTTP client
  #   c = Eson::Client.new(:server => "http://127.0.0.1:9200", 
  #                        :protocol => Eson::HTTP, 
  #                        :plugins => [Eson::ResponseParser], 
  #                        :logger => 'test/test.log')
  #
  #
  class Client
    attr_accessor :server
    attr_accessor :index_name
    attr_accessor :default_parameters
    attr_accessor :protocol
    attr_accessor :plugins
    attr_accessor :opts
    attr_accessor :auto_call
    attr_accessor :logger

    alias :node :server

    # Default settings
    DEFAULT_OPTS = {
                      :server => 'http://127.0.0.1:9200',
                      :plugins => [],
                      :logger => nil,
                      :default_parameters => { :index => "default" }
                   }

    # Create a new client. The client object is protocol-independent, but uses
    # Eson::HTTP by default.
    #
    # @param [Hash] opts the options to create the client with.
    # @option opts [String] :server ('http://127.0.0.1:9200') The base url of the server to connect to.
    # @option opts [Module] :protocol (Eson::HTTP) The module providing the protocol implementation.
    # @option opts [Array<Module>] :plugins ([]) An array of plugin modules
    # @option opts [String, #<<] :logger (nil) A logger object or a String pointing to a log file.
    # @option opts [true,false] :auto_call (true) Whether to immeditately run the request or return the
    #   request object instead.
    # @option opts [Hash] :auth (nil) Authentication information depending on protocol
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
        default_parameters[:index] ||= default_index
      end

      if self.auto_call.nil?
        self.auto_call = true
      end
    end
    
    # @deprecated
    def default_index=(index_name)
      default_index[:index] = index_name
    end

    # Returns a clone of this client with new {#default_parameters}. The
    # old parameters are merged with the new ones.
    #
    # @param [Hash] params The new parameters
    #
    # @return [Eson::Client] a clone of the client with the new parameters set.s
    def with(params = {})
      client = self.clone
      client.default_parameters = default_parameters.merge(params)

      if block_given?
        yield client
      else
        client
      end
    end

    # Check whether the client has auth options set at all.
    # 
    # @return [true,false] Whether auth parameters are set.
    # @api internal
    def auth?
      !!opts[:auth]
    end

    # Returns the auth parameters
    #
    # @api interal
    # @return [Hash] The auth parameters
    def auth
      opts[:auth]
    end

    # Set the logger.
    #
    # @overload
    #   @param [Logger, #<<] The logger object
    # @overload
    #   @param [String] A filepath to log to
    def logger=(logger)
      if String === logger
        require 'logger'
        @logger = Logger.new(logger)
      else
        @logger = logger
      end
    end

    # @!group Requests

    # @!macro request
    # @!macro immediate
    #
    # {include:Index#parameters}
    # {include:Index#source_param}
    # {include:Index#multi_index}
    # {include:Index#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::Index}.
    def index(args = {}, immediate = auto_call)
      request(protocol::Index, args, immediate)
    end
    
    # @!macro request
    # @!macro immediate
    #
    # {include:Delete#parameters}
    # {include:Delete#source_param}
    # {include:Delete#multi_index}
    # {include:Delete#multi_types}
    # @param [Hash] args The arguments, as given in {Eson::Shared::Delete}.
    def delete(args = {}, immediate = auto_call)
      request(protocol::Delete, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:Get#parameters}
    # {include:Get#source_param}
    # {include:Get#multi_index}
    # {include:Get#multi_types}
    # @param [Hash] args The arguments, as given in {Eson::Shared::Get}.
    def get(args = {}, immediate = auto_call)
      request(protocol::Get, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:MGet#parameters}
    # {include:MGet#source_param}
    # {include:MGet#multi_index}
    # {include:MGet#multi_types}
    # @param [Hash] args The arguments, as given in {Eson::Shared::MGet}.
    def mget(args = {}, immediate = auto_call)
      request(protocol::MultiGet, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:Search#parameters}
    # {include:Search#source_param}
    # {include:Search#multi_index}
    # {include:Search#multi_types}
    #
    # @yield If eson-dsl is used, the given block will be used as DSL defintion.
    # @param [Hash] args The arguments, as given in {Eson::Shared::Search}.
    def search(args = {}, immediate = auto_call, &block)
      request(protocol::Search, args, immediate, &block)
    end
    alias :query :search

    # @!macro request
    # @!macro immediate
    #
    # {include:Scroll#parameters}
    # {include:Scroll#source_param}
    # {include:Scroll#multi_index}
    # {include:Scroll#multi_types}
    #
    # @yield If eson-dsl is used, the given block will be used as DSL defintion.
    def scroll(args = {}, immediate = auto_call, &block)
      request(protocol::Scroll, args, immediate, &block)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:SimpleSearch#parameters}
    # {include:SimpleSearch#source_param}
    # {include:SimpleSearch#multi_index}
    # {include:SimpleSearch#multi_types}
    # 
    # @param [Hash] args The arguments, as given in {Eson::Shared::SimpleSearch}.
    def simple_search(args = {}, immediate = auto_call)
      request(protocol::SimpleSearch, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:Count#parameters}
    # {include:Count#source_param}
    # {include:Count#multi_index}
    # {include:Count#multi_types}
    # @param [Hash] args The arguments, as given in {Eson::Shared::Count}.
    def count(args = {}, immediate = auto_call)
      request(protocol::Count, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:Update#parameters}
    # {include:Update#source_param}
    # {include:Update#multi_index}
    # {include:Update#multi_types}
    # @param [Hash] args The arguments, as given in {Eson::Shared::Update}.
    def update(args = {}, immediate = auto_call)
      request(protocol::Update, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:Percolate#parameters}
    # {include:Percolate#source_param}
    # {include:Percolate#multi_index}
    # {include:Percolate#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::Percolate}.
    def percolate(args = {}, immediate = auto_call, &block)
      request(protocol::Percolate, args, immediate, &block)
    end

    # @!macro request
    #
    # {include:Bulk#parameters}
    # {include:Bulk#source_param}
    # {include:Bulk#multi_index}
    # {include:Bulk#multi_types}
    #
    # If this method is called with a block, the request is immediately called.
    # With no block given, the request will be returned.
    #
    # @yield The block is evaluated to create the subrequests.
    # @param [Hash] args The arguments, as given in {Eson::Shared::Bulk}.
    def bulk(args = {}, &block)
      if block_given?
        request(protocol::Bulk, args, &block)
      else
        request(protocol::Bulk, args, false)
      end
    end

    # @!macro request
    #
    # {include:MultiSearch#parameters}
    # {include:MultiSearch#source_param}
    # {include:MultiSearch#multi_index}
    # {include:MultiSearch#multi_types}
    #
    # If this method is called with a block, the request is immediately called.
    # With no block given, the request will be returned.
    #
    # @yield The block is evaluated to create the subrequests.
    # @param [Hash] args The arguments, as given in {Eson::Shared::MultiSearch}.
    def msearch(args = {}, &block)
      if block_given?
        request(protocol::MultiSearch, args, &block)
      else
        request(protocol::MultiSearch, args, false)
      end
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:DeleteByQuery#parameters}
    # {include:DeleteByQuery#source_param}
    # {include:DeleteByQuery#multi_index}
    # {include:DeleteByQuery#multi_types}
    #
    # @yield If eson-dsl is used, the given block will be used as DSL defintion.
    # # @param [Hash] args The arguments, as given in {Eson::Shared::DeleteByQuery}.
    def delete_by_query(args = {}, immediate = auto_call, &block)
      request(protocol::DeleteByQuery, args, immediate, &block)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:MoreLikeThis#parameters}
    # {include:MoreLikeThis#source_param}
    # {include:MoreLikeThis#multi_index}
    # {include:MoreLikeThis#multi_types}
    #
    # @yield If eson-dsl is used, the given block will be used as DSL defintion.
    # # @param [Hash] args The arguments, as given in {Eson::Shared::MoreLikeThis}.
    def more_like_this(args = {}, immediate = auto_call)
      request(protocol::MoreLikeThis, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:Health#parameters}
    # {include:Health#source_param}
    # {include:Health#multi_index}
    # {include:Health#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::Health}.
    def health(args = {}, immediate = auto_call)
      request(protocol::Health, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:State#parameters}
    # {include:State#source_param}
    # {include:State#multi_index}
    # {include:State#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::State}.
    def state(args = {}, immediate = auto_call)
      request(protocol::State, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:Stats#parameters}
    # {include:Stats#source_param}
    # {include:Stats#multi_index}
    # {include:Stats#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::Stats}.
    def stats(args = {}, immediate = auto_call)
      request(protocol::Stats, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:Nodes#parameters}
    # {include:Nodes#source_param}
    # {include:Nodes#multi_index}
    # {include:Nodes#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::Nodes}.
    def nodes(args = {}, immediate = auto_call)
      request(protocol::Nodes, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:Shutdown#parameters}
    # {include:Shutdown#source_param}
    # {include:Shutdown#multi_index}
    # {include:Shutdown#multi_types}
    #
    # Please be aware that external node shutdown does not seem to be 
    # supported by ElasticSearch at the moment.
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::Shutdown}.
    def shutdown(args = {}, immediate = auto_call)
      request(protocol::Shutdown, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:Alias#parameters}
    # {include:Alias#source_param}
    # {include:Alias#multi_index}
    # {include:Alias#multi_types}
    #
    # @yield The block is evaluated in the context of the request 
    #   to define the aliases
    # @param [Hash] args The arguments, as given in {Eson::Shared::Aliases}.
    def aliases(args = {}, immediate = auto_call, &block)
      request(protocol::Aliases, args, immediate, &block)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:Analyze#parameters}
    # {include:Analyze#source_param}
    # {include:Analyze#multi_index}
    # {include:Analyze#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::Analyze}.
    def analyze(args = {}, immediate = auto_call)
      request(protocol::Analyze, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:ClearCache#parameters}
    # {include:ClearCache#source_param}
    # {include:ClearCache#multi_index}
    # {include:ClearCache#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::ClearCache}.
    def clear_cache(args = {}, immediate = auto_call)
      request(protocol::ClearCache, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:CloseIndex#parameters}
    # {include:CloseIndex#source_param}
    # {include:CloseIndex#multi_index}
    # {include:CloseIndex#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::CloseIndex}.
    def close_index(args = {}, immediate = auto_call)
      request(protocol::CloseIndex, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:OpenIndex#parameters}
    # {include:OpenIndex#source_param}
    # {include:OpenIndex#multi_index}
    # {include:OpenIndex#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::OpenIndex}.
    def open_index(args = {}, immediate = auto_call)
      request(protocol::OpenIndex, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:CreateIndex#parameters}
    # {include:CreateIndex#source_param}
    # {include:CreateIndex#multi_index}
    # {include:CreateIndex#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::CreateIndex}.
    def create_index(args = {}, immediate = auto_call)
      request(protocol::CreateIndex, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:DeleteIndex#parameters}
    # {include:DeleteIndex#source_param}
    # {include:DeleteIndex#multi_index}
    # {include:DeleteIndex#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::DeleteIndex}.
    def delete_index(args = {}, immediate = auto_call)
      request(protocol::DeleteIndex, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:DeleteMapping#parameters}
    # {include:DeleteMapping#source_param}
    # {include:DeleteMapping#multi_index}
    # {include:DeleteMapping#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::DeleteMapping}.
    def delete_mapping(args = {}, immediate = auto_call)
      request(protocol::DeleteMapping, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:GetMapping#parameters}
    # {include:GetMapping#source_param}
    # {include:GetMapping#multi_index}
    # {include:GetMapping#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::GetMapping}.
    def get_mapping(args = {}, immediate = auto_call)
      request(protocol::GetMapping, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:PutMapping#parameters}
    # {include:PutMapping#source_param}
    # {include:PutMapping#multi_index}
    # {include:PutMapping#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::PutMapping}.
    def put_mapping(args = {}, immediate = auto_call)
      request(protocol::PutMapping, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:PutTemplate#parameters}
    # {include:PutTemplate#source_param}
    # {include:PutTemplate#multi_index}
    # {include:PutTemplate#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::PutTemplate}.
    def put_template(args = {}, immediate = auto_call)
      request(protocol::PutTemplate, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:GetTemplate#parameters}
    # {include:GetTemplate#source_param}
    # {include:GetTemplate#multi_index}
    # {include:GetTemplate#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::GetTemplate}.
    def get_template(args = {}, immediate = auto_call)
      request(protocol::GetTemplate, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:DeleteTemplate#parameters}
    # {include:DeleteTemplate#source_param}
    # {include:DeleteTemplate#multi_index}
    # {include:DeleteTemplate#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::DeleteTemplate}.
    def delete_template(args = {}, immediate = auto_call)
      request(protocol::DeleteTemplate, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:GetSettings#parameters}
    # {include:GetSettings#source_param}
    # {include:GetSettings#multi_index}
    # {include:GetSettings#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::GetSettings}.
    def get_settings(args = {}, immediate = auto_call)
      request(protocol::GetSettings, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:UpdateSettings#parameters}
    # {include:UpdateSettings#source_param}
    # {include:UpdateSettings#multi_index}
    # {include:UpdateSettings#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::UpdateSettings}.
    def update_settings(args = {}, immediate = auto_call)
      request(protocol::UpdateSettings, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:Flush#parameters}
    # {include:Flush#source_param}
    # {include:Flush#multi_index}
    # {include:Flush#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::Flush}.
    def flush(args = {}, immediate = auto_call)
      request(protocol::Flush, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:Optimize#parameters}
    # {include:Optimize#source_param}
    # {include:Optimize#multi_index}
    # {include:Optimize#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::Optimize}.
    def optimize(args = {}, immediate = auto_call)
      request(protocol::Optimize, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:Refresh#parameters}
    # {include:Refresh#source_param}
    # {include:Refresh#multi_index}
    # {include:Refresh#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::Refresh}.
    def refresh(args = {}, immediate = auto_call)
      request(protocol::Refresh, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:Snapshot#parameters}
    # {include:Snapshot#source_param}
    # {include:Snapshot#multi_index}
    # {include:Snapshot#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::Snapshot}.
    def snapshot(args = {}, immediate = auto_call)
      request(protocol::Snapshot, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:Status#parameters}
    # {include:Status#source_param}
    # {include:Status#multi_index}
    # {include:Status#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::Status}.
    def status(args = {}, immediate = auto_call)
      request(protocol::Status, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:IndexStats#parameters}
    # {include:IndexStats#source_param}
    # {include:IndexStats#multi_index}
    # {include:IndexStats#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::IndexStats}.
    def index_stats(args = {}, immediate = auto_call)
      request(protocol::IndexStats, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:Segments#parameters}
    # {include:Segments#source_param}
    # {include:Segments#multi_index}
    # {include:Segments#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::Segments}.
    def segments(args = {}, immediate = auto_call)
      request(protocol::Segments, args, immediate)
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:IndexExists#parameters}
    # {include:IndexExists#source_param}
    # {include:IndexExists#multi_index}
    # {include:IndexExists#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::IndexExists}.
    def exists?(args = {}, immediate = auto_call)
      request(protocol::IndexExists, args)
    rescue Eson::NotFoundError
      false
    end

    # @!macro request
    # @!macro immediate
    #
    # {include:Explain#parameters}
    # {include:Explain#source_param}
    # {include:Explain#multi_index}
    # {include:Explain#multi_types}
    #
    # @param [Hash] args The arguments, as given in {Eson::Shared::Explain}.
    def explain(args = {}, immediate = auto_call)
      request(protocol::Explain, args)
    end
    # @!endgroup

    private
      # @api internal
      def request(endpoint, args, auto_call = auto_call)
        r = protocol::Request.new(endpoint, plugins, self)
        
        r.set_parameters_without_exceptions(default_parameters)
        r.parameters = args
        
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