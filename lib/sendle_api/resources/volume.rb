module SendleAPI
  class Volume < Base
    include NotSaveable

    DEFAULT_ATTRS = {
      value: nil,
      units: nil
    }
    validates :units, inclusion: { in: %w(m3 in3) }, if: -> {value.present?}
  end
end