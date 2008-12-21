# music.rb
require 'rubygems'
require 'sinatra'

# Defined in config.rb.  Use config.rb.example as a template.
require 'config'

helpers do
  # No funny business. Send 'em home if the path isn't found.
  def get_entries(path)
    redirect '/' unless File.exist? path
    Dir.entries(path).reject {|e| e =~ /^\./}
  end
  
  def get_mp3(path)
    throw :halt , '' unless File.exist? path
    IO.read(path)
  end
end


get '/' do
  @entries = Dir.entries(MUSIC_BASE).reject {|e| e =~ /^\./}.sort
  erb :index
end

get '/:artist/:album/:song.mp3' do
  get_mp3(MUSIC_BASE + "/#{params[:artist]}/#{params[:album]}/#{params[:song]}.mp3")
end

get '/:artist/:album' do
  @entries = get_entries(MUSIC_BASE + "/#{params[:artist]}/#{params[:album]}")
  erb :album, :layout => false
end

get '/:artist' do
  @entries = get_entries(MUSIC_BASE + "/#{params[:artist]}")
  erb :artist
end
