class App
 
  def call(env)
    query_params = env['QUERY_STRING'].to_s.split(/=|%2C/)
    return send_responce(no_page_status, no_page_body) if env['REQUEST_PATH'] != '/time'

    check_result = check_request(query_params)
    if check_result[:errors].empty?
      send_responce(success_status, check_result[:time_in_format])
    else
      send_responce(bad_params_status, check_result[:errors])
    end
  end

  private

  def send_responce(status, body)
    responce = Rack::Response.new( 200, [ 'Content-Type' => 'application/json' ], ['d', '3'])
    [status, headers, [body]]
  end

  def no_page_body
    ["not found \n"]
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

  def check_request(query_params)
    query_params.shift
    result = []
    wrong_params = []
    query_params.each do |query|
      format_for_result = check_query(query)
      format_for_result.nil? ? wrong_params << query : result << format_for_result
    end
    { time_in_format: "#{DateTime.now.strftime(result.join('-'))} \n", errors: wrong_params }
  end

  def check_query(query)
    time_format = { year: '%Y',
                    month: '%m',
                    day: '%d',
                    hour: '%h',
                    minute: '%M',
                    second: '%S' }
    time_format[query.to_sym]
  end
end
