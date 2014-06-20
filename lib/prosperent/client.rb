require 'httparty'
require 'prosperent/configuration'
require 'prosperent/error'
require 'prosperent/version'

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
        !response["errors"].empty?
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
      @merged_options = Prosperent.options.merge(options)
 
      # Copy the merged values to this client and ignore those
      # not part of our configuration
      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", @merged_options[key])
      end
    end

    def products params, options={}
      url = build_search_query("/search", options[:zone])

      response = make_get_request(url , params.merge(authentication_params))
    end

    def brands params, options={}
      response = make_get_request("/brand", params)
    end

    def celebrities params, options={}
      response = make_get_request("/celebrity", params)
    end

    private

    def build_search_query action, options_zone

      zone = ( options_zone || @merged_options[:zone] ).to_s.downcase

      if ["","uk","ca"].include?(zone)
        zone = zone.empty? ? "" : "/#{zone}"
      else
        zone = ""
      end

      return action.prepend(zone)
    end

    def make_post_request url, body, headers = {'Content-Type' => 'application/json'}
      self.class.post(url.to_s, :body => body, :headers => headers)
    end

    def make_get_request url, params
      self.class.get(url.to_s, query: params)
    end

    def authentication_params
      {
        api_key: @merged_options[:api_key]
      }
    end
 
  end # Client
 
end
