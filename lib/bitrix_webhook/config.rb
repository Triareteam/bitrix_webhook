module BitrixWebhook; class Config

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :bitrix24_url
    attr_accessor :hook
    attr_accessor :hook_id

    def initialize
      @bitrix24_url= 'bitrix24_url'
      @hook =  'hook'
      @hook_id =  'id'
    end
  end
end; end