module Eson
  module Search
    class QueryString
      include Query
      
      short_name :query_string
      
      attr_accessor :options
      
      def initialize(options = {})
        if Hash === options 
          self.options = options
        else
          self.options = {:query => options.to_s }
        end
      end
    end
  end
end