require 'uri'
require 'rubygems'
require File.join(File.dirname(__FILE__), 'lib', 'sinatra_uri_char_fix')
require 'sinatra'
require File.join(File.dirname(__FILE__), 'config', 'sinatra')
require File.join(File.dirname(__FILE__), 'lib', 'helpers')

# Specify files that should be hidden from lists. i.e.: album.jpg is a special
# file used within the UI, and should not be included in an album track list.
configure do
  HIDE_LIST = ['lost+found', 'album.jpg', 'iTunes']
end

get '/library/*.mp3' do
  get_mp3(MUSIC_BASE+ "/#{params['splat'].first}.mp3")
end

get '/*' do
  @entries = get_entries(MUSIC_BASE+ "/#{params['splat']}")
  @back = params['splat'].first.empty? ? nil : File.dirname("/#{params['splat']}")
  erb :listing
end
