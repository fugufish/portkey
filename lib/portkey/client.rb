# frozen_string_literal: true

require "faraday"

module Portkey
  ##
  # Base URL for the Portkey API.
  BASE_URL = "https://api.portkey.ai"

  ##
  # The client class for the Portkey API.
  class Client
    class RequestError < Portkey::Error
      def initialize(response)
        super("Request to '#{response.env.url}' failed with status #{response.status}\n#{response.body}")
      end
    end

    class << self
      def create(body:, metadata: {}, **options)
        new(**options).create(body:, metadata:)
      end

      def update(id:, body:, metadata: {}, **options)
        new(**options).update(id:, body:, metadata:)
      end

      def delete(id:, metadata: {}, **options)
        new(**options).delete(id:, metadata:)
      end

      def show(id:, metadata: {}, **options)
        new(**options).show(id:, metadata:)
      end

      def index(metadata: {}, **options)
        new(**options).index(metadata:)
      end
    end

    def initialize(**_options)
      @faraday = Faraday.new(url: BASE_URL) do |faraday|
        faraday.headers["Content-Type"] = "application/json"
        faraday.headers["Accept"] = "application/json"
        faraday.headers["x-portkey-api-key"] = Portkey.api_key
        faraday.adapter Portkey.faraday_adapter
      end
    end

    def create(body:, metadata: {})
      response = faraday.post(url, body.to_json, metadata)

      handle_response(response)
    end

    def update(id:, body:, metadata: {})
      response = faraday.put(url(id), body.to_json, metadata)

      handle_response(response)
    end

    def delete(id:, metadata: {})
      response = faraday.delete(url(id), metadata)

      handle_response(response)
    end

    def show(id:, metadata: {})
      response = faraday.get(url(id), metadata)

      handle_response(response)
    end

    def index(metadata: {})
      response = faraday.get(url(id), metadata)

      handle_response(response)
    end

    private

    attr_reader :faraday

    def url(id = nil)
      return path if id.nil?

      path.gsub(":id", id.to_s)
    end

    def handle_response(response)
      raise RequestError, response if response.status != 200

      JSON.parse(response.body)
    end
  end
end
