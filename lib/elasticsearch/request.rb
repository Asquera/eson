module ElasticSearch
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

    def params=(params)
      params.each do |k,v|
        self.send("#{k}=", v)
      end
    end

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

    # TODO: woah, this needs refactoring

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
