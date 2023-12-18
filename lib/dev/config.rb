# frozen_string_literal: true

require "dotenv/load"

def set_config
  SendleAPI.configure do |config|
    config.sendle_id = ENV["SENDLE_ID"]
    config.api_key = ENV["SENDLE_API_KEY"]
    config.testing = true
  end
end
