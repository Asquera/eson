module Eson
  module Shared
    module Update
      extend API
      
      multi_index false
      
      parameters :timeout, 
                 :type, 
                 :routing,
                 :parent,
                 :id,
                 :consistency,
                 :percolate,
                 :refresh,
                 :script,
                 :params
      
      source_param :script,
                   :params
    end
  end
end