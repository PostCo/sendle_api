require "active_support/core_ext/array/wrap"
require "active_support/core_ext/object/blank"

module SendleAPI
  class Errors < ActiveResource::Errors
    def from_hash(messages, save_cache = false)
      clear unless save_cache

      add(:base, messages["error_description"]) if messages["error_description"]

      messages["messages"].each do |(key, errors)|
        errors.each do |error|
          if @base.known_attributes.include?(key)
            add(key, error)
          elsif key == "base"
            add(:base, error)
          else
            # reporting an error on an attribute not in attributes
            # format and add them to base
            add(:base, "#{key.humanize} #{error}")
          end
        end
      end
    end
  end
end
