module Eson
  module StatusHandler
    def call(*args)
      handle(super)
    end

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