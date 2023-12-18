# frozen_string_literal: true

require "zeitwerk"
require_relative "config"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect(
  "sendle_api" => "SendleAPI",
)
loader.push_dir("./lib")
loader.collapse("./lib/sendle_api/resources")
loader.ignore("#{__dir__}/config.rb")
loader.enable_reloading
# loader.log!
loader.setup

$__sendle_api_loader__ = loader

def reload!
  $__sendle_api_loader__.reload
  set_config
  true
end
