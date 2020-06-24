
module SendleAPI
  class Weight < Base
    include NotSaveable

    DEFAULT_ATTRS = {
      value: nil,
      units: nil
    }

    validates :value, presence: true
    validates :units, inclusion: { in: %w(lb kg)   }
  end
end