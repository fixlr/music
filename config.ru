require 'rubygems'
require 'sinatra'

Sinatra::Application.default_options.merge!(
  :run => false,
  :env => :production
)

log = File.new("sinatra.log", "w")
STDOUT.reopen(log)
STDERR.reopen(log)

use Rack::Auth::Basic do |username, password|
  username == 'replace' && password == 'me'
end

require 'init'
run Sinatra.application