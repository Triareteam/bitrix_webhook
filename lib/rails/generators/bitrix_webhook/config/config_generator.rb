module BitrixWebhook
  module Generators
    class ConfigGenerator < Rails::Generators::Base
    
      def self.source_root
        @_bitrix_webhook_source_root ||= File.expand_path("../templates", __FILE__)
      end

      def create_initializer_file
        template 'initializer.rb', File.join('config', 'initializers', 'bitrix_webhook.rb')
        puts 'Configure file was created!'
        puts 'Please configure this file  config/initializers/bitrix_webhook.rb'
      end
    end
  end
end
