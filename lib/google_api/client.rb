module GoogleApi
  class Client
    BASE_URL = Settings.google_api.base_url
    API_KEY = Settings.google_api.youtube_api_key
    class << self
      def get_video_info(video_id)
        url = "youtube/v3/videos?part=snippet&id=#{video_id}&key=#{API_KEY}"
        response = connection.get(url)
        handle_response(response)
      end

      private
      def handle_response(response, is_json: true)
        begin
          body = response.body.force_encoding('utf-8')
          result = if is_json
                    JSON.parse(body, object_class: OpenStruct)
                  else
                    body
                  end
        rescue JSON::ParserError
          puts "[handle response] Failed! Not perform parse json action"
          nil
        end

        case response.status
        when 200 then result || nil
        else
          puts "[handle response] Something went wrong!"
          nil
        end
      end

      def headers
        {
          "Content-Type" => "application/json",
        }
      end

      def connection
        Faraday.new(
          url: BASE_URL,
          headers: headers
        )
      end
    end
  end
end
