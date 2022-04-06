# frozen_string_literal: true

module SendleAPI
  class Product < Base
    include NotSaveable

    self.prefix = "/api/products"
    self.element_name = ""
  end
end
