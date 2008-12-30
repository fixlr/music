require File.join(File.dirname(__FILE__), 'test_helper')
require 'mocha'

class MusicHelpersTest < Test::Unit::TestCase
  def setup
    request = mock('request')
    response = mock('response', :body= => nil)
    route_params = mock('route_params')
    @context = Sinatra::EventContext.new(request, response, route_params)
  end

  test 'url_for' do
    assert_equal '/Foo%20Bar', @context.url_for("Foo Bar")
    assert_equal '/Foo/Bar', @context.url_for("Foo", "Bar")
    assert_equal '/Foo/Bar/test.mp3', @context.url_for('Foo', 'Bar', 'test.mp3')
  end

  test 'get_entries' do
    assert_equal ['&,.#', 'Foo'], @context.get_entries(MUSIC_BASE + '/')
    assert_equal ['Bar'], @context.get_entries(MUSIC_BASE + '/Foo')
    assert_equal ['test.mp3'], @context.get_entries(MUSIC_BASE + '/Foo/Bar')
    assert_nil @context.get_entries(MUSIC_BASE + '/').find {|e| e =~ /^\./ }
    # 404
    # sorted
  end

  test 'get_mp3' do
    # return the contents from the mp3 path
    # halt if 404
  end

  test 'get_album_jpg' do
    # return the contents of album.jpg
    # return default album2.jpg if 404
  end

  test 'title' do
    # index
    # artist
    # artist : album
  end
end