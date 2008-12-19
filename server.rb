# music.rb
require 'rubygems'
require 'sinatra'

# Defined in config.rb.  Use config.rb.example as a template.
require 'config'

get '/' do
  @entries = Dir.entries(MUSIC_BASE).reject {|e| e =~ /^\./}.sort
  erb :index
end

get '/:artist/:album/:song.mp3' do
  IO.read(MUSIC_BASE + "/#{params[:artist]}/#{params[:album]}/#{params[:song]}.mp3")
end

get '/:artist/:album' do
  @entries = Dir.entries(MUSIC_BASE + "/#{params[:artist]}/#{params[:album]}").reject {|e| e =~ /^\./}
  erb :album, :layout => false
end

get '/:artist' do
  @entries = Dir.entries(MUSIC_BASE + "/#{params[:artist]}").reject {|e| e =~ /^\./}
  erb :artist
end
