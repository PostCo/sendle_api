require "sendle_api/version"
require "active_resource"

module SendleAPI
  require "phonelib"
  require "countries"

  require "sendle_api/configuration"
  require "sendle_api/not_saveable"
  require "sendle_api/errors"
  require "sendle_api/connection"

  require "sendle_api/resources/base"
  require "sendle_api/resources/tracking"
  require "sendle_api/resources/contact"
  require "sendle_api/resources/address"
  require "sendle_api/resources/sender"
  require "sendle_api/resources/receiver"
  require "sendle_api/resources/volume"
  require "sendle_api/resources/weight"
  require "sendle_api/resources/order"
  require "sendle_api/resources/product"
end
