
require "active_support/core_ext/array/wrap"
require "active_support/core_ext/object/blank"

module SendleAPI
  class Errors < ActiveModel::Errors
    # Grabs errors from an array of messages (like ActiveRecord::Validations).
    # The second parameter directs the errors cache to be cleared (default)
    # or not (by passing true).
    def from_array(messages, save_cache = false)
      clear unless save_cache
      humanized_attributes = Hash[@base.known_attributes.map { |attr_name| [attr_name.humanize, attr_name] }]
      messages.each do |message|
        attr_message = humanized_attributes.keys.sort_by { |a| -a.length }.detect do |attr_name|
          if message[0, attr_name.size + 1] == "#{attr_name} "
            add humanized_attributes[attr_name], message[(attr_name.size + 1)..-1]
          end
        end
        self[:base] << message if attr_message.nil?
      end
    end

    # Grabs errors from a hash of attribute => array of errors elements
    # The second parameter directs the errors cache to be cleared (default)
    # or not (by passing true)
    #
    # Unrecognized attribute names will be humanized and added to the record's
    # base errors.
    def from_hash(messages, save_cache = false)
      clear unless save_cache

      # delete top level not-needed keys
      messages.delete("error")
      messages.delete("error_description")
 
      messages.each do |(key, errors)|
        errors.each do |error|
          if @base.known_attributes.include?(key)
            add key, error
          elsif key == "base"
            self[:base] << error
          else
            # reporting an error on an attribute not in attributes
            # format and add them to base
            self[:base] << "#{key.humanize} #{error}"
          end
        end
      end
    end

    # Grabs errors from a json response.
    def from_json(json, save_cache = false)
      decoded = ActiveSupport::JSON.decode(json) || {} rescue {}
      if decoded.kind_of?(Hash) && (decoded.has_key?("errors") || decoded.empty?)
        errors = decoded["errors"] || {}
        if errors.kind_of?(Array)
          # 3.2.1-style with array of strings
          ActiveSupport::Deprecation.warn("Returning errors as an array of strings is deprecated.")
          from_array errors, save_cache
        else
          # 3.2.2+ style
          from_hash errors, save_cache
        end
      else
        # <3.2-style respond_with - lacks 'errors' key
        ActiveSupport::Deprecation.warn('Returning errors as a hash without a root "errors" key is deprecated.')
        from_hash decoded, save_cache
      end
    end
  end
end