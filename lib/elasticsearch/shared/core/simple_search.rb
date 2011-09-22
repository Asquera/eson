module ElasticSearch
  module Shared
    module SimpleSearch
      extend API
      
      multi_index true
      
      attr_accessor :type
      
      parameters :timeout, 
                 :types, 
                 :q,
                 :routing,
                 :df,
                 :analyzer,
                 :fields,
                 :sort,
                 :track_scores,
                 :timeout,
                 :from,
                 :size,
                 :search_type
      
       def types
         if @types
           Array(@types)
         elsif type
           Array(type)
         else
           []
         end
       end
    end
  end
end