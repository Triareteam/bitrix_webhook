module BitrixWebhook
  module CRM
    module LEAD

      DEFAULT = {
          fname: '',
          lname: '',
          status_id: 'NEW',
          opened:  'Y',
          assigned_by_id: BitrixWebhook.hook_id,
          register_sonet_event: 'Y',
      }

      def self.base_url(method)
        "https://#{BitrixWebhook.bitrix24_url}/rest/#{BitrixWebhook.webhook_hook_id}/#{ BitrixWebhook.hook}/crm.lead.#{method}.json?"
      end

      def self.add(options = {})
        options = DEFAULT.merge(options )
        post_url =  base_url("add").to_s + "fields%5BTITLE%5D=#{options[:fname].to_s + '+' + options[:lname].to_s}&" +
                                                    "fields%5BNAME%5D=#{options[:fname]}&" +
                                                    "fields%5BLAST_NAME%5D=#{options[:lname]}&" +
                                                    "fields%5BSTATUS_ID%5D=#{options[:status_id]}&" +
                                                    "fields%5BOPENED%5D=#{options[:opened]}&" +
                                                    "fields%5BASSIGNED_BY_ID%5D=#{options[:assigned_by_id]}&" +
                                                    "fields%5BPHONE%5D%5B0%5D%5BVALUE%5D=#{options[:phone]}&" +
                                                    "fields%5BEMAIL%5D%5B0%5D%5BVALUE%5D=#{options[:email]}&" +
                                                    "params%5BREGISTER_SONET_EVENT%5D=#{options[:register_sonet_event]}"

        begin
          JSON.parse(HTTP.post(post_url).body)
        rescue => e
          {error:e}.to_json
        end
      end

    end
  end
end