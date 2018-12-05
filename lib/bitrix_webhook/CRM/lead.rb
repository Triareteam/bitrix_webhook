module BitrixWebhook
  module CRM
    module LEAD

      def self.config
        {
            fname: '',
            lname: '',
            status_id: 'NEW',
            opened:  'Y',
            assigned_by_id: BitrixWebhook.webhook_user,
            register_sonet_event: 'Y',
        }
      end

      def self.base_url(method)
        "https://#{BitrixWebhook.bitrix24_url}/rest/#{BitrixWebhook.webhook_user}/#{ BitrixWebhook.hook}/crm.lead.#{method}?"
      end

      def self.add(options = {})
        options = config.merge(options )
        query_params = {
            fields:
                { TITLE: "#{options[:fname]} #{options[:lname]}",
                  NAME: options[:fname],
                  LAST_NAME: options[:lname],
                  STATUS_ID: options[:status_id],
                  OPENED: options[:opened],
                  ASSIGNED_BY_ID: options[:assigned_by_id],
                  PHONE: { '0': { VALUE: options[:phone] } },
                  EMAIL: { '0': { VALUE: options[:email] } } },
            params: {
                REGISTER_SONET_EVENT: options[:register_sonet_event]
            }
        }.to_query
        post_url = base_url('add').to_s + query_params

        begin
          JSON.parse(HTTP.post(post_url).body)
        rescue => e
          {error:e}.to_json
        end
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

      def self.update_one_filed(id,filed,value)
        query_params = {
            id: id,
            fields: {
                filed => value
            }
        }.to_query
        post_url = base_url('update').to_s + query_params


        begin
          JSON.parse(HTTP.post(post_url).body)
        rescue => e
          {error:e}.to_json
        end
      end

    end

    LEAD.singleton_class.send(:alias_method, :update_one_field, :update_one_filed)
  end
end