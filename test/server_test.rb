require File.join(File.dirname(__FILE__), 'test_helper')

class MusicServerTest < Test::Unit::TestCase
  test 'get on /' do
    get_it '/'
    assert_equal 200, @response.status
    assert_equal get_entries(MUSIC_BASE).to_s, @response.body
  end
  
  test 'get on /artist' do
    get_it '/Foo'
    assert_equal 200, @response.status
    assert_equal get_entries(MUSIC_BASE + '/Foo').to_s, @response.body
  end
  
  test 'get an /artist with funky characters' do
    funky_uri = URI.escape '/Funky&'
    get_it funky_uri
    assert_equal 200, @response.status
    assert_equal get_entries(MUSIC_BASE + URI.unescape(funky_uri)).to_s, @response.body
  end
  
  test 'get on /artist does not exist' do
    get_it '/nobody'
    assert_equal 302, @response.status
    assert_equal '/', @response.headers['Location']
    assert_equal '', @response.body
  end
  
  test 'get on /artist/album' do
    get_it '/Foo/Bar'
    assert_equal 200, @response.status
    assert_equal get_entries(MUSIC_BASE + '/Foo/Bar').to_s, @response.body
  end
  
  test 'get on /artist/album does not exist' do
    get_it '/Foo/Nothing'
    assert_equal 302, @response.status
    assert_equal '/', @response.headers['Location']
    assert_equal '', @response.body
  end
  
  test 'get on /artist/album/file.mp3 exists' do
    get_it '/Foo/Bar/test.mp3'
    assert_equal 'Hello world', @response.body
    assert_equal 200, @response.status
  end
  
  test 'get on /artist/album/file.mp3 does not exist' do
    get_it '/Foo/Bar/Nothing.mp3'
    assert_equal '', @response.body
  end
  
  def get_entries(path)
    Dir.entries(path).reject {|e| e =~ /^\./}.sort
  end
end