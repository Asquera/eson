module Eson
  # A request is a generic object that implements parameter manipulation
  # methods and Esons plugin API. It is always bound to a client.
  #
  # This class cannot be used directly but must be subclassed by protocol
  # implementations. Proper implementations must respond to `#call`.
  #
  # @example constructing a request by hand
  #   r = protocol::Request.new(protocol::IndexExists, [ResponseParser], client)
  class Request
    attr_accessor :api, :client

    attr_accessor :pretty, :source, :index, :indices, :case

    
    def initialize(api, plugins, client)
      self.api = api
      self.client = client
      self.extend(api)

      Array(plugins).each do |p|
        if pluggable?(api, p, client)
          self.extend(p)
        end
      end
    end

    # This is a default implementation of `handle_block` that can be overriden
    # by apis or plugins.
    #
    # @yield self
    def handle_block
      yield self
    end

    # This is an internal method that allows the client to set default
    # parameters to requests without having to check for the presence of the
    # method beforehand.
    #
    # @api internal
    def set_parameters_without_exceptions(params)
      params.each do |k,v|
        begin
          self.send("#{k}=", v)
        rescue NoMethodError => e
          #drop
        end
      end
    end

    # Mass assignment of parameters to a request. Invalid parameters will
    # raise an exception.
    #
    # @param [Hash] params The parameters, keyed by name
    # @raise [NoMethodError]
    def parameters=(params)
      params.each do |k,v|
        begin
          self.send("#{k}=", v)
        rescue NoMethodError => e
          raise NoMethodError, "Tried to set parameter `#{k}`, but request has no such parameter."
        end
      end
    end

    # Checks whether a Plugin works with a certain type of request. For example,
    # Search plugins usually only work with Search requests. The decision is up
    # to the plugin. If the plugin does not list a set of APIs that it works
    # with, it will be considered compatible to all.
    #
    # @param [Eson::Api] api the api in question
    # @param [Module] plugin the plugin module
    # @param [Eson::Client] client the client to which the plugin should be added
    #
    # @return [true,false] Whether the plugin is compatible or not.
    # @api internal
    def pluggable?(api, plugin, client)
      if plugin.respond_to? :plugin_for
        plugin.plugin_for(client.protocol).include?(api)
      else
        true
      end
    end

    def index
      @index || client.index_name
    end

    def parameters
      if self.respond_to?(:multi_index) && (multi_index == true)
        [:pretty, :indices, :case]
      elsif self.respond_to?(:multi_index) && (multi_index == false)
        [:pretty, :index, :case]
      else
        [:pretty, :case]
      end
    end

    def indices
      if @indices
        Array(@indices)
      else
        Array(self.index)
      end
    end

    def source
      @source || source_from_params
    end

    # Extracts the source parameters from the parameter set.
    #
    # @return [String] the request source, as String
    def source_from_params
      return nil unless self.respond_to? :source_param

      if Symbol === source_param
        obj = self.send source_param
        if (String === obj || obj.nil?)
          return obj
        else
          return encode(obj)
        end
      else
        pairs = source_param.map do |p|
          if v = self.send(p)
            [p, v]
          else
            nil
          end
        end
        pairs.compact!

        return nil if pairs.empty?

        obj = {}

        pairs.each do |p, v|
          obj[p] = v
        end

        return encode(obj)
      end
    end

    # Encode any object. If it is an {Eson}-Object and responds to 
    # `to_query_hash`, this will be preferred. Otherwise, MultiJson is used.
    #
    # @param [Object] obj the object to encode
    # @return [String] the object, encoded as JSON
    def encode(obj)
      if obj.respond_to? :to_query_hash
        obj = obj.to_query_hash
      end

      if obj.respond_to? :to_json
        obj.to_json
      else
        MultiJson.encode(obj)
      end
    end
  end
end
