require 'sinatra/lib/sinatra'
require 'rubygems'

Sinatra::Application.default_options.merge!(
  :run => false,
  :env => :production
)

require 'server.rb'
run Sinatra.application