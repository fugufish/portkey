# frozen_string_literal: true

require "spec_helper"

RSpec.describe Portkey::Completions do
  describe "::create" do
    it "makes a valid request to the api" do
      response = VCR.use_cassette("completions_create") do
        described_class.create(body: {
                                 model: "gpt-3.5-turbo-instruct",
                                 prompt: "What is the capital of the United States?"
                               },
                               virtual_key: ENV.fetch("PORTKEY_VIRTUAL_KEY"))
      end

      expect(response).to be_a(Hash)
      expect(response).to have_key("id")
      expect(response).to have_key("model")
      expect(response["model"]).to eq("gpt-3.5-turbo-instruct")
    end
  end
end
