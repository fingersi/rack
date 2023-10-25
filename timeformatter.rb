class TimeFormatter

  TIME_FORMAT = { year: '%Y',
                  month: '%m',
                  day: '%d',
                  hour: '%h',
                  minute: '%M',
                  second: '%S'}

  def time_in_format(query_params)
    body = []
    query_params.each do |query|
      params_in_format = TIME_FORMAT[query.to_sym]
      params_in_format.nil? ? errors << query : body << params_in_format
    end

    return { body: errors.join(','), errors: true } if errors.any?

    { body: "#{ DateTime.now.strftime(body.join('-')) }", errors: false }
  end
end