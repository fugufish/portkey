# frozen_string_literal: true

module Portkey
  module Chats
    class Completions < VirtualKeyClient
      private

      def path
        "/v1/chats/completions"
      end
    end
  end
end
