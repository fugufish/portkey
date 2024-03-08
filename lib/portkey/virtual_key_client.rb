# frozen_string_literal: true

require_relative "client"

module Portkey
  class VirtualKeyClient < Client
    def initialize(virtual_key:)
      super
      faraday.headers["x-portkey-virtual-key"] = virtual_key
    end
  end
end
