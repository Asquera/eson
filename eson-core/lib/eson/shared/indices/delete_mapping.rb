module Eson
  module Shared
    module DeleteMapping
      extend API
            
      parameters :type
      
      multi_index true
    end
  end
end