class TimeFormatter

  TIME_FORMAT = { year: '%Y',
                  month: '%m',
                  day: '%d',
                  hour: '%h',
                  minute: '%M',
                  second: '%S'}

  def initialize(query_params)
    @body = []
    @errors = []
    check_params(@body, @errors,query_params)
  end

  def check_params(body, errors, query_params)
    query_params.each do |query|
      params_in_format = TIME_FORMAT[query.to_sym]
      params_in_format.nil? ? errors << query : body << params_in_format
    end
  end

  def valid?
    @errors.empty?
  end

  def time_string
    "#{ DateTime.now.strftime(@body.join('-')) }"
  end

  def error_string
    "wrong parameters: #{@errors.join(',')}"
  end
end