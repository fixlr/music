require 'uri'
require 'rubygems'

# I'm seeing some problems with special characters in artist/album/song names
# that result in 404 errors with Sinatra. Overriding URI_CHAR fixes it (see 
# accompanying tests). Not sure if there's a better way though...
# Must be loaded before Sinatra or it will not work.
require File.join(File.dirname(__FILE__), 'lib', 'sinatra_uri_char_fix')
require 'sinatra'

# Defined in config.rb.  Use config.rb.example as a template.
require File.expand_path(File.dirname(__FILE__) + '/lib/config')

helpers do
  # No funny business. Send 'em home if the path isn't found.
  def get_entries(path)
    redirect '/' unless File.exist? path
    Dir.entries(path).reject {|e| e =~ /^\./}.sort
  end
  
  def get_mp3(path)
    throw :halt , '' unless File.exist? path
    IO.read(path)
  end
  
  def get_album_jpg(path)
    throw :halt, IO.read(File.join(File.dirname(__FILE__), 'public', 'image', 'album2.jpg')) unless File.exist? path
    IO.read(path)
  end
  
  def url_for(*args)
    '/' + args.map {|e| URI.escape(e) }.join('/')
  end
end


get '/' do
  @entries = Dir.entries(MUSIC_BASE).reject {|e| e =~ /^\./}.sort
  erb :index
end

get '/:artist/:album/album.jpg' do
  get_album_jpg(File.join(MUSIC_BASE, params[:artist], params[:album], 'album.jpg'))
end

get '/:artist/:album/:song' do
  get_mp3(MUSIC_BASE + "/#{params[:artist]}/#{params[:album]}/#{params[:song]}")
end

get '/:artist/:album' do
  @entries = get_entries(MUSIC_BASE + "/#{params[:artist]}/#{params[:album]}").reject {|e| e == 'album.jpg'}
  erb :album, :layout => false
end

get '/:artist' do
  @entries = get_entries(MUSIC_BASE + "/#{params[:artist]}")
  erb :artist
end
