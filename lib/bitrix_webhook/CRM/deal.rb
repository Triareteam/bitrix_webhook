module BitrixWebhook
  module CRM
    module DEAL

      def self.base_url(method)
        "https://#{BitrixWebhook.bitrix24_url}/rest/#{BitrixWebhook.webhook_user}/#{ BitrixWebhook.hook}/crm.deal.#{method}?"
      end

      def self.get(id)
        query_params = {
            id: id
        }.to_query
        get_url = base_url('get').to_s + query_params
        begin
          JSON.parse(HTTP.get(get_url).body)
        rescue => e
          {error:e}.to_json
        end
      end

    end
  end
end