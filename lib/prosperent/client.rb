require 'httparty'
require 'prosperent/configuration'
require 'prosperent/error'

module Prosperent
  extend Configuration

  class Client
    include HTTParty

    base_uri Prosperent.options[:endpoint]
    headers 'User-Agent' => Prosperent.options[:user_agent]

    class << self

      # Check every response for errors and raise
      def perform_request(http_method, path, options, &block)
        response = super(http_method, path, options, &block)
        check_response(response)
        response
      end

      def check_response(response)
        raise Prosperent::Error.from_response(response) if response_errors?(response)
      end

      def response_errors?(response)
        puts response
        return false

        # response.body =~ /^ERROR: .+/ || !response.response.is_a?(Net::HTTPSuccess)
      end

    end

 
    # Define the same set of accessors as the Prosperent module
    attr_accessor *Configuration::VALID_CONFIG_KEYS
 
    def initialize(options={})
      # Merge the config values from the module and those passed to the class.
      options.delete(:endpoint)
      options.delete_if { |k, v| v.nil? }

      # Merge the config values from the module and those passed
      # to the client.
      merged_options = Prosperent.options.merge(options)
 
      # Copy the merged values to this client and ignore those
      # not part of our configuration
      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end
 
  end # Client
 
end
