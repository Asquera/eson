module Eson
  module Shared
    module UpdateSettings
      extend API
      
      parameters :settings
      source_param :settings
      
      multi_index true
    end
  end
end