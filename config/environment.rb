# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

Time::DATE_FORMATS[:date_time_env] = "%d/%m/%Y"
Time::DATE_FORMATS[:date_time_env_specific] = "%d/%m/%Y ás %H:%M:%S"