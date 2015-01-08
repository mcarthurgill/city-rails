CityRails::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :log

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5
end
