# frozen_string_literal: true

module SendleAPI
  class Contact < Base
    include NotSaveable

    validates :name, presence: true

    DEFAULT_ATTRS = {
      name: nil,
      # phone: nil,
      # company: nil
    }

    FIELDS = [:name, :phone, :company]
  end
end
