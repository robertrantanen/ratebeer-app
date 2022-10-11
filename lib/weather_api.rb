class WeatherApi
  def self.weather_in(city)
    city = city.downcase
    Rails.cache.fetch(city, expires_in: 1.days) { get_weather_in(city) }
  end

  def self.get_weather_in(city)
    url = "http://api.weatherstack.com/current?access_key=#{key}&query="

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"

    return response.parsed_response["current"]
  end

  def self.key
    return nil if Rails.env.test?
    raise 'WEATHER_APIKEY env variable not defined' if ENV['WEATHER_APIKEY'].nil?

    ENV.fetch('WEATHER_APIKEY')
  end
end
