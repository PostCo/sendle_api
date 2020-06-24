module SendleAPI
  class Base < ::ActiveResource::Base

    validate :child_object_validations

    self.include_root_in_json = false
    self.include_format_in_path = false
    self.connection_class = Connection
    self.prefix = '/api/'

    def initialize(attributes = {}, persisted = false)
      if defined?(self.class::DEFAULT_ATTRS)
        attributes = self.class::DEFAULT_ATTRS.merge(attributes)
      end
      super
    end

    def save
      self.class.validate_configs
      super
    end
    
    def errors
      @errors ||= Errors.new(self)
    end

    private

    def child_object_validations
      if defined?(self.class::CHILD_OBJECT_KEYS_FOR_VALIDATION)
        self.class::CHILD_OBJECT_KEYS_FOR_VALIDATION.each do |obj|
          if !attributes[obj].nil? && !send(obj).valid?
            send(obj).errors.messages.each do |msg_key, messages|
              messages.each do |message|
                errors.add("#{obj}_#{msg_key}".to_sym, message)
              end
            end
          end
        end
      end
    end

    class << self

      def set_site
        self.site = if SendleAPI.config.testing?
           "https://#{basic_auth_details}@sandbox.sendle.com"
        else
          "https://#{basic_auth_details}@api.sendle.com"
        end
      end

      def basic_auth_details
        "#{SendleAPI.config.sendle_id}:#{SendleAPI.config.api_key}"
      end

      def validate_configs
        unless SendleAPI.config.sendle_id
          raise ArgumentError, "SendleAPI sendle_id is missing, please set it in the config and restart."
        end

        unless SendleAPI.config.api_key
          raise ArgumentError, "SendleAPI api_key is missing, please set it in the config and restart."
        end
      end
    end
  end
end
