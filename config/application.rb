require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WeatherApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.after_initialize do
      redis = Redis.new
       if redis
        redis.set("Santiago", {longitude: "-33.454743", latitude: "-70.660382"}.to_json)
        redis.set("Zurich",   {longitude: "47.381483",  latitude: "8.545130"}.to_json)
        redis.set("Auckland", {longitude: "-36.876945", latitude: "174.761096"}.to_json)
        redis.set("Sydney",   {longitude: "-33.886662", latitude: "151.197477"}.to_json)
        redis.set("Londres",  {longitude: "51.503724",  latitude: "-0.125821"}.to_json)
        redis.set("Georgia",  {longitude: "42.093953",  latitude: "43.408664"}.to_json)
       end
    end

  end
end
