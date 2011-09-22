module ElasticSearch
  module Shared
    module Aliases
      extend API
      
      no_indices true
      
      parameters :actions
      source_param [:actions]
      
      def add(index, aka)
        actions << {"add" => { "index" => index, "alias" => aka}}
      end
      
      def remove(index, aka)
        actions << {"remove" => { "index" => index, "alias" => aka}}
      end
      
      def actions
        @actions ||= []
      end
    end
  end
end