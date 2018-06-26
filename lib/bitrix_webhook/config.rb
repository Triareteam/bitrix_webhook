module BitrixWebhook
  class Config

    class << self
      attr_accessor :configuration

      def configure
        self.configuration ||= Configuration.new

        yield(configuration)
      end

    end

    class Configuration
      attr_accessor :bitrix24_url
      attr_accessor :hook
      attr_accessor :webhook_user

      def initialize
        @bitrix24_url = 'bitrix24_url'
        @hook = 'hook'
        @webhook_user = 'id'
      end

    end

  end
end
