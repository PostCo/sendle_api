module SendleAPI
  class Receiver < Base
    include NotSaveable

    has_one :contact, class_name: Contact
    has_one :address, class_name: Address

    validates :contact, :address, :instructions, presence: true

    DEFAULT_ATTRS = {
      contact: Contact.new,
      address: Address.new,
      instructions: ""
    }

    CHILD_OBJECT_KEYS_FOR_VALIDATION = [:contact, :address]
  end
end
