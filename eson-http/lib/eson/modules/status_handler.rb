module Eson
  # A plugin to handle status codes.
  module StatusHandler
    def call(*args)
      handle(super)
    end

    # Handle the response status.
    #
    # @raise [Eson::IndexNotFoundError] if the index is missing
    # @raise [Eson::NotFoundError] if the document is missing
    # @raise [Eson::Error] otherwise
    def handle(response)
      case response.status
      when 404
        if /IndexMissingException/.match(response.body)
          raise Eson::IndexNotFoundError.new(response.body, response)
        else
          raise Eson::NotFoundError.new(response, response)
        end
      else
        if response.status >= 400
          raise Eson::Error.new(response[:error], response)
        else
          response
        end
      end
    end
  end
end