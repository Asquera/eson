module Eson
  module Shared
    module PutMapping
      extend API
      
      multi_index true
      
      parameters :type,
                 :ignore_conflicts,
                 :mapping
      
      source_param :mapping
    end
  end
end