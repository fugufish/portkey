# frozen_string_literal: true

require_relative "virtual_key_client"

module Portkey
  class Completions < VirtualKeyClient
    private

    def path
      "/v1/completions"
    end
  end
end
