module SendleAPI
  class Sender < Base
    include NotSaveable

    has_one :contact, class_name: Contact
    has_one :address, class_name: Address

    validates :contact, :address, presence: true
    validate :address_country_valid
    
    DEFAULT_ATTRS = {
      contact: Contact.new,
      address: Address.new,
      instructions: ""
    }

    CHILD_OBJECT_KEYS_FOR_VALIDATION = [:contact, :address]

    private

    def address_country_valid
      return unless address
      
      valid_sender_countries = ['AU', 'US', 'Australia', 'United States']
      unless valid_sender_countries.include? address.country
        errors.add(:sender_address_country, "Must be from #{valid_sender_countries}")
      end
    end
  end
end
