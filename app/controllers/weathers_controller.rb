class WeathersController < ApplicationController
  before_action :get_weather_information
  def index
  end

  private

  def redis
    @redis = Redis.new
  end

  def cities
    @cities = %w[Santiago Zurich Auckland Sydney Londres Georgia]
  end

  def get_weather_information
    @cities_information = {}
    cities.each do |city|
      @cities_information[city] = JSON.parse(redis.get(city + '_weather'))
    end
    @cities_information
  end
end
