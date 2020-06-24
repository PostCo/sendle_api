module SendleAPI
  class Configuration
    attr_accessor :sendle_id, :api_key, :testing
    alias_method :testing?, :testing

    def initialize
      # default
      @testing = false
    end
  end

  def self.config
    @config ||= Configuration.new
  end

  def self.config=(config)
    @config = config
  end

  def self.configure
    yield config
    SendleAPI::Base.set_site
  end
end
