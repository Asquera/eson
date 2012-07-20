module Eson
  # A plugins that parses HTTP responses as json and returns the json
  module ResponseParser
    # This exception subclass representds parse errors. In addition to saving
    # the response, it also saves the JSON source in a special field.
    class JSONParseError < Eson::Error
      attr_accessor :source
    end

    # Evaluate the plugin.
    #
    # @param [Array<Object>] args Any number of args used for calling the endpoint.
    # @return [Hash, Array] the parsed json
    # @raise [JSONParseError] ES returned invalid JSON
    def call(*args)
      parse(super)
    end

    # Parse the response.
    #
    # @param [#body] response The response
    # @return [Hash, Array] the parsed json
    # @raise [JSONParseError] ES returned invalid JSON
    def parse(response)
      begin
        MultiJson.decode(response.body) if response.body
      rescue MultiJson::DecodeError => e
        error = JSONParseError.new(e.message, response)
        error.source = response.body
        raise error
      end
    end
  end
end