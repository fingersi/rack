class TimeFormatter

  TIME_FORMAT = { year: '%Y',
                  month: '%m',
                  day: '%d',
                  hour: '%h',
                  minute: '%M',
                  second: '%S'}

  def check_request(query_params)    
    errors = []
    query_params.each do |query|
      errors << query if TIME_FORMAT[query.to_sym].nil?
    end 
    errors
  end

  def time_by_format(query_params) 
    "#{DateTime.now.strftime(query_params.map{|query| TIME_FORMAT[query.to_sym]}.join('-'))} \n"
  end
end