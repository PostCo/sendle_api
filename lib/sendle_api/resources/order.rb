require 'digest/sha1'

module SendleAPI
  class Order < Base
    has_one :weight, class_name: Weight
    has_one :volume, class_name: Volume
    has_one :sender, class_name: Sender
    has_one :receiver, class_name: Receiver

    validates :description, :weight, :sender, :receiver, presence: true
    validates :first_mile_option, inclusion: { in: ["pickup", "drop off"]}

    DEFAULT_ATTRS = {
      pickup_date: nil,
      first_mile_option: nil,
      description: nil,
      customer_reference: nil,
      metadata: {},
      contents: {},
      weight: Weight.new,
      volume: Volume.new,
      sender: Sender.new,
      receiver: Receiver.new
    }

    CHILD_OBJECT_KEYS_FOR_VALIDATION = [:weight, :volume, :sender, :receiver]

    def save
      set_idempotency_key_header
      result = super
      set_order_id_as_id
      result
    end

    def track
      if attributes["sendle_reference"]
        attributes[:tracking] = Tracking.find(sendle_reference)
      else
        raise ArgumentError, "sendle_reference not found in attributes"
      end
    end

    private

    def set_order_id_as_id
      attributes[:id] = attributes[:order_id]
    end

    def set_idempotency_key_header
      self.class.headers.merge!("Idempotency-Key": Digest::SHA1.hexdigest(self.encode))
    end

  end
end
