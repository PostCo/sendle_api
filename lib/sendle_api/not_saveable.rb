module SendleAPI
  module NotSaveable
    def self.create(**args)
      raise NotImplementedError, "This class is a non-writable resource."
    end

    def save
      raise NotImplementedError, "This object is a non-writable resource."
    end

    def update
      save
    end

    def update_attribute(**args)
      save
    end

    def update_attributes(**args)
      save
    end
  end
end