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
