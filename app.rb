class App

  require_relative 'timeformatter'

  NO_PAGE_BODY = "not found \n"
  SUCCESS_STATUS = 200
  NO_PAGE_STATUS = 404
  BAD_PARAMS_STATUS = 400
  HEADERS = { "Content-type" => "text/plain" }

  def call(env)
    return send_responce(NO_PAGE_STATUS, no_page_body) if env['REQUEST_PATH'] != '/time'
    
    query_params = env['QUERY_STRING'].to_s.split(/=|%2C/)

    return send_responce(BAD_PARAMS_STATUS, ["bad request - no 'format=' in url"]) if query_params[0] != 'format'

    query_params.shift
    tf = TimeFormatter.new()    
    errors = tf.check_request(query_params)
    return send_responce(BAD_PARAMS_STATUS, "wrong params: #{errors.join(',') }") if !errors.empty?

    send_responce(SUCCESS_STATUS, tf.time_by_format(query_params))
  end

  private

  def send_responce(status, body)
    res = Rack::Response.new  
    res.status = status
    res.header['Content_Type'] = 'text/plain'
    res.write(body) 
    res.finish
  end
end
