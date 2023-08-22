require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require 'dotenv'
Dotenv.load

module TicketEvent
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.assets.css_compressor = Escompress::Compressor.new(loader: :css)

    config.action_mailer.default_url_options = { host: ENV["ACTION_MAILER_HOST"], port: ENV["ACTION_MAILER_PORT"] }

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.eager_load_paths << Rails.root.join("lib")
    config.active_storage.content_types_to_serve_as_binary -= ['image/svg+xml']
  end
end
