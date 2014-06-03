module Prosperent
  
  class Error < StandardError
    attr_reader :code

    class << self
      # Create a new error from an HTTP response
      def from_response(response)
        message, code = parse_error(response)
        klass = errors[code] || self
        klass.new(message, code)
      end

      def errors
        @errors ||= {
          400 => Prosperent::Error::BadRequest,
          401 => Prosperent::Error::Unauthorized,
          403 => Prosperent::Error::Forbidden,
          404 => Prosperent::Error::NotFound,
          406 => Prosperent::Error::NotAcceptable,
          408 => Prosperent::Error::RequestTimeout,
          422 => Prosperent::Error::UnprocessableEntity,
          500 => Prosperent::Error::InternalServerError,
          502 => Prosperent::Error::BadGateway,
          503 => Prosperent::Error::ServiceUnavailable,
          504 => Prosperent::Error::GatewayTimeout,
        }
      end

      private

      def parse_error(response)
        [ response["errors"].empty? ? "" : response["errors"] , response.code ]
      end

    end

    # Initializes a new Error object
    def initialize(message = '', code = nil)
      super(message)
      @code = code
    end

    # Raised if Prosperent returns a 4xx HTTP status code
    class ClientError < self; end

    # Raised if Prosperent returns the HTTP status code 400
    class BadRequest < ClientError; end

    # Raised if Prosperent returns the HTTP status code 401
    class Unauthorized < ClientError; end

    # Raised if Prosperent returns the HTTP status code 403
    class Forbidden < ClientError; end

    # Raised if Prosperent returns the HTTP status code 404
    class NotFound < ClientError; end

    # Raised if Prosperent returns the HTTP status code 406
    class NotAcceptable < ClientError; end

    # Raised if Prosperent returns the HTTP status code 408
    class RequestTimeout < ClientError; end

    # Raised if Prosperent returns the HTTP status code 422
    class UnprocessableEntity < ClientError; end

    # Raised if Prosperent returns a 5xx HTTP status code
    class ServerError < self; end

    # Raised if Prosperent returns the HTTP status code 500
    class InternalServerError < ServerError; end

    # Raised if Prosperent returns the HTTP status code 502
    class BadGateway < ServerError; end

    # Raised if Prosperent returns the HTTP status code 503
    class ServiceUnavailable < ServerError; end

    # Raised if Prosperent returns the HTTP status code 504
    class GatewayTimeout < ServerError; end
  end
end