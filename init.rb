require 'uri'
require 'ostruct'
require 'rubygems'
require File.join(File.dirname(__FILE__), 'lib', 'sinatra_uri_char_fix')
require 'sinatra'
require File.join(File.dirname(__FILE__), 'config', 'sinatra')

# Specify files that should be hidden from lists. i.e.: album.jpg is a special
# file used within the UI, and should not be included in an album track list.
configure do
  HIDE_LIST = ['lost+found', 'album.jpg', 'iTunes']
end

helpers do
  # No funny business. Send 'em home if the path isn't found.
  def get_entries(path)
    redirect '/' unless File.exist? path
    Dir.entries(path).reject {|e| e =~ /^\./}.sort - HIDE_LIST
  end
  
  def get_mp3(path)
    throw :halt , '' unless File.exist? path
    IO.read(path)
  end
  
  def title
    params['splat'].first.empty? ? 'MUSIC' : params['splat']
  end
  
  def url_for(*args)
    (args.last.downcase =~ /\.mp3$/ ? '/library/' : '/') + args.map {|e| URI.escape("#{e}") }.join('/').sub(/^\//, '')
  end
end

get '/library/*.mp3' do
  get_mp3(MUSIC_BASE+ "/#{params['splat'].first}.mp3")
end

get '/*' do
  @entries = get_entries(MUSIC_BASE+ "/#{params['splat']}")
  @back = params['splat'].first.empty? ? nil : File.dirname("/#{params['splat']}")
  erb :listing
end
