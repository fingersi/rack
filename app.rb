class App

  require_relative 'timeformatter'
 
  def call(env)
    query_params = env['QUERY_STRING'].to_s.split(/=|%2C/)
    tf = TimeFormatter.new()

    return send_responce(no_page_status, no_page_body) if env['REQUEST_PATH'] != '/time'
    
    check_result = tf.check_request(query_params)

    unless check_result[:errors]
      send_responce(success_status, check_result[:body])
    else
      send_responce(bad_params_status, check_result[:body])
    end
  end

  private

  def send_responce(status, body)
    [status, headers, [body]]
  end

  def no_page_body
    "not found \n"
  end

  def success_status
    200
  end

  def no_page_status
    404
  end

  def bad_params_status
    400
  end

  def headers
    { "Content-type" => "text/plain" }
  end
end
