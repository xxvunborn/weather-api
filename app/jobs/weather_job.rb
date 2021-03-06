require 'forecast_io'
if defined? Dotenv
  require 'dotenv/load'
end

class WeatherJob
  include Sidekiq::Worker

  def perform
    cities_coordinates.each do |city|
      forecast = ForecastIO.forecast(city[1]['longitude'], city[1]['latitude'])
      redis.set(city[0] + '_weather', forecast['currently'].to_json)
    end
    WeatherDataJob.perform_later
  end

  private

  def cities_coordinates
    cities_name = %w[Santiago Zurich Auckland Sydney Londres Georgia]
    cities = {}
    cities_name.each do |city|
      cities[city] = JSON.parse(redis.get(city))
    end
    cities
  end

  def redis
    @redis = Redis.new
  end

  ForecastIO.configure do |configuration|
    configuration.api_key = ENV['FORECAST_KEY']
  end
end
