module Eson
  module Search
    class CustomScore
      
      include Queries
      include Query
      
      short_name :custom_score
      
      attr_accessor :options
      
      def initialize(options = {})
        self.options = options
      end
      
    end
  end
end