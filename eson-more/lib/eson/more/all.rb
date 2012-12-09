module Eson
  module More
    module All
      DEFAULT_OPTS = {:search_type => :scan, :scroll => "10m", :size => 50}

      module Functions
        def self.fetch_more_results(client, scroll_id)
          result = client.scroll(:scroll_id => scroll_id, :scroll => "10m")
          scroll_id = result["_scroll_id"]

          results = client.extract_hits(result)
          scroll_id = nil if results.empty?

          return scroll_id, results
        end
      end

      # Retrieves all documents matching a given option set. Automatically 
      # handles scrolling.
      # 
      # @param [Hash] opts the options to retrieve documents
      def all(opts)
        scroll_response = search(DEFAULT_OPTS.merge(opts))
        scroll_id = scroll_response["_scroll_id"]

        if block_given?
          while scroll_id
            scroll_id, results = Functions.fetch_more_results(self, scroll_id)
            yield results
          end
        else
          docs = []
          while scroll_id
            scroll_id, results = Functions.fetch_more_results(self, scroll_id)
            docs += results
          end
          docs
        end
      end
    end
  end
end

Eson::Client.class_eval {
  include Eson::More::All
}