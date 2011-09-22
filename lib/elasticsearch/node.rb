module ElasticSearch
  module Node
    def self.new(*args)
      if RUBY_ENGINE == 'jruby'
        Native.new(*args)
      else
        External.new(*args)
      end
    end
    
    class Native
      def initialize(cluster_name = "default")
        settings = org.elasticsearch.common.settings.ImmutableSettings.settingsBuilder.put("cluster.name", cluster_name).put("gateway.type", "none").put("number_of_shards", 1)
        
        @node ||= org.elasticsearch.node.NodeBuilder.nodeBuilder.settings(settings).node
      end
      
      def client
        @node.client
      end
      
      def info
        
      end
      
      def close
        @node.close
      end
    end
    
    class External
      def initialize
        
      end
      
      def close
        
      end
    end
  end
end