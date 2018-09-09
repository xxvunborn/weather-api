class WeatherDataJob < ApplicationJob
  queue_as :default

  def perform
    ActionCable.server.broadcast 'weathers_channel', message: weathers_data
  end

  private

  def weathers_data
    cities_name = %w[Santiago Zurich Auckland Sydney Londres Georgia]
    cities = {}
    redis = Redis.new
    cities_name.each do |city|
      cities[city] = JSON.parse(redis.get(city + '_weather'))
    end
    cities
  end

end
