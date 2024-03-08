# frozen_string_literal: true

require_relative "portkey/version"

module Portkey
  class Error < StandardError; end

  class << self
    # rubocop:disable ThreadSaftey/InstanceVariableInClassMethod
    ##
    # @return [Faraday::Adapter] The Faraday adapter set for the Portkey API.
    def faraday_adapter
      @faraday_adapter ||= Faraday.default_adapter
    end

    ##
    # @return [String] The Portkey API key.
    def api_key
      @api_key ||= ENV.fetch("PORTKEY_API_KEY")
    end

    # rubocop:disable ThreadSaftey/ClassAndModuleAttributes
    #
    ##
    # @!attribute [w] faraday_adapter The Faraday adapter set for the Portkey API.
    attr_writer :faraday_adapter
    ##
    # @!attribute [w] api_key The Portkey API key.
    attr_writer :api_key

    # rubocop:enable ThreadSaftey/ClassAndModuleAttributes
    # rubocop:enable ThreadSaftey/InstanceVariableInClassMethod
  end
end

require "portkey/completions"
