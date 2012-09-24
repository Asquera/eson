module Eson
  module Search
    class Indices
      include Query

      # @macro eson.query
      short_name :indices

      attr_accessor :indices, :no_match_val, :query_val

      def initialize(*indices)
        self.indices = indices
      end

      def query(&block)
        self.query_val ||= SubQuery.new(args)
        self.query_val.send(context, &Proc.new)
      end

      def no_match_query(no_match_val = nil)
        if no_match_val
          self.no_match_val = no_match_val
        elsif block_given?
          self.no_match_val ||= SubQuery.new(args)
          self.no_match_val.send(context, &Proc.new)
        end
      end

      def to_query_hash
        options = {
          :indices => indices,
          :query => self.query_val.to_query_hash,
        }

        if no_match_val
          if no_match_val.respond_to? :to_query_hash
            no_match = no_match_val.to_query_hash
          else
            no_match = no_match_val
          end
          options.merge!(:no_match_query => no_match)
        end
  
        { name => options }
      end
    end
  end
end