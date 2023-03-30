class WeatherService < ApplicationService
  def initialize(data)
    @postal = data['address']['postcode']
    @lat = data['lat']
    @lon = data['lon']
    @url = "https://api.openweathermap.org/data/2.5/weather?lat=#{@lat}&lon=#{@lon}&units=imperial&appid=#{ENV['OWM_API_KEY']}"
  end
  
  def call
    # we check if there is a postal code
    # sometimes some addresses do not have postal codes
    if @postal
      recent_data = Cache.check_for_recent(@postal)
      recent_data ? cached_data(recent_data) : api_data
    else
      api_data
    end
  end

  private

  def api_data
    response = HTTParty.get(@url)
    formatted_data = format_response(response.body)
    Cache.create_or_update(@postal, formatted_data) if @postal
    formatted_data.merge('cache' => false)
  end

  def cached_data(recent_data)
    recent_data.data.merge('cache' => true)
  end

  def format_response(body)
    json_resp = JSON.parse body

    json = {}
    json['weather'] = json_resp['weather'][0]['main']
    json['temp'] = json_resp['main']['temp'].to_i
    json['min'] = json_resp['main']['temp_min'].to_i
    json['max'] = json_resp['main']['temp_max'].to_i

    json
  end
end