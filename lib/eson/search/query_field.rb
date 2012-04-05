require 'ostruct'

module Eson
  module Search
    class QueryField < OpenStruct
      def initialize(name, *fields)
        @_name = name
        
        if fields.length == 1 && Hash === fields.first
          super(fields.first)
        else
          @list = fields
        end
      end
      
      def to_query_hash
        if @list
          { _name => @list }
        else
          { _name => @table }
        end
      end
      
      def _name
        @_name
      end
      
      def _options
        @_table
      end
    end
  end
end