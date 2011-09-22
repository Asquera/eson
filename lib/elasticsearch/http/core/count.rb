module ElasticSearch
  module HTTP
    module Count
      include Search
      
      def path
        bare_path + "_count"
      end
    end
  end
end