require 'sidekiq-scheduler'
require 'forecast_io'
require 'dotenv/load'
#require 'action_cable/engine'
require 'active_job'

class WeatherJob
  include Sidekiq::Worker
  #include ActionCable::Server::Connections
  #include ActionCable::Server::Broadcasting

  def perform
    cities_coordinates.each do |city|
      forecast = ForecastIO.forecast(city[1]['longitude'], city[1]['latitude'])
      redis.set(city[0] + '_weather', forecast['currently'].to_json)
    end
    #ActionCable.server.broadcast 'weathers_channel', message: '<p>Hello World!</p>'
    WeatherDataJob.perform_later
  end

  private

  def weathers_data
    cities_name = %w[Santiago Zurich Auckland Sydney Londres Georgia]
    cities = {}
    cities_name.each do |city|
      cities[city] = JSON.parse(redis.get(city + '_weather'))
    end
    cities
  end

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
