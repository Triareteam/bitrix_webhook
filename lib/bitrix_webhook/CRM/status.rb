module BitrixWebhook
  module CRM
    module STATUS

      def self.base_url(method)
        "https://#{BitrixWebhook.bitrix24_url}/rest/#{BitrixWebhook.webhook_user}/#{ BitrixWebhook.hook}/crm.status.#{method}?"
      end

      def self.list
        get_url = base_url('list').to_s
        begin
          JSON.parse(HTTP.get(get_url).body)
        rescue => e
          {error:e}.to_json
        end
      end

    end
  end
end