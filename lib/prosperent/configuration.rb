require 'prosperent/version'

module Prosperent
  module Configuration
    VALID_CONNECTION_KEYS = [:endpoint, :user_agent, :method, :zone].freeze
    VALID_OPTIONS_KEYS    = [:api_key, :format].freeze
    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS
 
    DEFAULT_ENDPOINT    = 'http://api.prosperent.com/api'
    DEFAULT_METHOD      = :get
    DEFAULT_USER_AGENT  = "Prosperent API Ruby Gem #{Prosperent::VERSION}".freeze
 
    DEFAULT_API_KEY      = nil
    DEFAULT_FORMAT       = :json

    DEFAULT_ZONE         = nil

    # Build accessor methods for every config options so we can do this, for example:
    #   Prosperent.format = :xml
    attr_accessor *VALID_CONFIG_KEYS
 
    # Make sure we have the default values set when we get 'extended'
    def self.extended(base)
      base.reset
    end
 
    def reset
      self.endpoint   = DEFAULT_ENDPOINT
      self.method     = DEFAULT_METHOD
      self.user_agent = DEFAULT_USER_AGENT
 
      self.api_key      = DEFAULT_API_KEY
      self.format       = DEFAULT_FORMAT
      self.zone         = DEFAULT_ZONE
    end

    def configure
      yield self
    end

    def options
      Hash[ * VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten ]
    end
 
  end # Configuration
end