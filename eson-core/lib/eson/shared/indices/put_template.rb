module Eson
  module Shared
    module PutTemplate
      extend API
      
      parameters :template, :settings, :mappings, :name
      source_param :template, :settings, :mappings
    end
  end
end