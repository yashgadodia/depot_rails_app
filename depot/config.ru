# This file is used by Rack-based servers to start the application.
#called a rackup file - "hey we want to run a web server" - knows how to hand of requests that come in to your application
require_relative 'config/environment'

run Rails.application
