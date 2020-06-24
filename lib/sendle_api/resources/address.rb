module SendleAPI
  class Address < Base
    include NotSaveable

    DEFAULT_ATTRS = {
      address_line1: nil,
      suburb: nil,
      state_name: nil,
      postcode: nil,
      country: nil
    }

    validates :address_line1, :suburb, :state_name, :postcode, :country, presence: true
  end
end