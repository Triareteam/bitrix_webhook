module BitrixWebhook
  module TASK
    module ITEM

      def self.config
        {
            responsible_id: BitrixWebhook.webhook_user
        }
      end

      def self.base_url(method)
        "https://#{BitrixWebhook.bitrix24_url}/rest/#{BitrixWebhook.webhook_user}/#{ BitrixWebhook.hook}/task.item.#{method}?"
      end

      def self.add(options = {})
        options = config.merge(options)
        query_params = {
            fields: {
                TITLE: options[:title],
                RESPONSIBLE_ID: options[:responsible_id],
                DEADLINE: (DateTime.now + 1.day).strftime("%FT%T%:z"),
                UF_CRM_TASK: ["L_#{options[:crm_user_id]}"]
            },
        }.to_query
        post_url = base_url('add').to_s + query_params

        begin
          JSON.parse(HTTP.post(post_url).body)
        rescue => e
          {error:e}.to_json
        end
      end


      def self.getdata(task_id)
        query_params = {
            TASKID: task_id
        }.to_query
        post_url = base_url('getdata').to_s + query_params

        begin
          JSON.parse(HTTP.post(post_url).body)
        rescue => e
          {error:e}.to_json
        end
      end

    end
  end
end