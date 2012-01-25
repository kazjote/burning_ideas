require 'sprockets'

Sprockets.register_engine '.haml', Tilt::HamlTemplate

map '/' do
  environment = Sprockets::Environment.new
  environment.append_path 'javascripts'
  environment.append_path 'stylesheets'
  environment.append_path 'templates'
  run environment
end
