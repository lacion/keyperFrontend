$: << File.dirname(File.expand_path(__FILE__))
require "lib/app"

map '/' do
  run App::Base
end