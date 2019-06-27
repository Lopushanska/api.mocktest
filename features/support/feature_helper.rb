module FeatureHelper
  def get_response(method, url)
    request_url = STRINGS['url'] + url.to_s
    begin
      case method
      when 'GET'
        RestClient.get request_url
      # when 'POST'
      #   RestClient.post request_url, {email:'first_name.last_name@gmail.com',firstName:'first_name',lastName:'last_name'}.to_json, {content_type: :json, accept: :json}
      # when 'PUT'
      #   RestClient.put request_url, {email:'jonny.worker@gmail.com', firstName: 'Jonny',lastName: 'Worker'}.to_json, {content_type: :json, accept: :json}
      # when'PATCH'
      #   RestClient.patch request_url, {email:'elom.musk@gmail.com'}.to_json, {content_type: :json, accept: :json}
      when'DELETE'
        RestClient.delete request_url
      when 'HEAD'
        RestClient.head request_url
      when 'OPTIONS'
        RestClient.options request_url
      end
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end

  def wrong_method_error
    raise STRINGS['error_message']
  end
end

World(FeatureHelper)
