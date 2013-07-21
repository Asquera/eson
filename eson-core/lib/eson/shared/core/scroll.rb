module Eson
  module Shared
    module Core
      # Requests using this API have the following properties:
      #
      # {include:Scroll#parameters}
      # {include:Scroll#source_param}
      # {include:Scroll#multi_index}
      # {include:Scroll#multi_types}
      module Scroll
        extend API

        # @!macro parameters
        parameters :scroll_id,
                   :scroll
      end
    end
  end
end
