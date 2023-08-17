class App

  def call(env)
    @result_time_format = []
    @wrong_params = []
    redexp = /=|%2C/
    query_params = env['QUERY_STRING'].to_s.split(redexp)
    return send_no_page if env['REQUEST_PATH'] != '/time'

    query_params.shift
    check_request(query_params)
     puts "result_time_format= #{@result_time_format}"
    @wrong_params.empty? ? success_responce(@result_time_format) : error_responce(@wrong_params)
  end

  private

  def success_responce(time_params)
    [success_status, headers, ["#{DateTime.now.strftime(time_params.join('-'))} \n"]]
  end

  def error_responce(wrong_params)
    [bab_params_status, headers, ["Unknown time format #{wrong_params.join(', ')} \n"]]
  end

  def send_no_page
    [no_page_status, headers, ["not found \n"]]
  end

  def success_status
    200
  end

  def no_page_status
    404
  end

  def bab_params_status
    400
  end

  def headers
    { "Content-type" => "text/plain" }
  end

  def check_request(query_params)
    result = []
    wrong_params = []
    query_params.each { |query|
      format_for_result = check_query(query)
      format_for_result.nil? ? wrong_params << query : result << format_for_result
    }
    puts "result = #{result} "
    @result_time_format = result
    @wrong_params = wrong_params
  end

  def  check_query(query)
    case query
    when 'year'
      '%Y'
    when 'month'
      '%m'
    when 'day'
      '%d'
    when 'hour'
      '%h'
    when 'minute'
      '%M'
    when 'second'
      '%S'
    else
      nil
    end
  end
end
