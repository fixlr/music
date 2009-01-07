require 'rubygems'
require File.dirname(__FILE__) + '/lib/sinatra_uri_char_fix'
require 'sinatra'

Sinatra::Application.default_options.merge!(
  :run => false,
  :env => :production
)

log = File.new("log/sinatra.log", "a")
STDOUT.reopen(log)
STDERR.reopen(log)

use Rack::Auth::Basic do |username, password|
  username == 'replace' && password == 'me'
end

require 'init'
run Sinatra.application