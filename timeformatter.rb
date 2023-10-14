class TimeFormatter
  def check_request(query_params)
    query_params.shift
    right_params = []
    wrong_params = []
    query_params.each do |query|
      format_for_result = check_query(query)
      format_for_result.nil? ? wrong_params << query : right_params << format_for_result
    end

    if wrong_params.empty?
      { body: "#{DateTime.now.strftime(right_params.join('-'))} \n", errors: false  }
    else
      { body: "Wrong params[#{wrong_params.join(',')}] \n", errors: true }
    end
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