require File.join(File.dirname(__FILE__), 'test_helper')

class MusicHelpersTest < Test::Unit::TestCase
  def setup
    request = mock('request')
    response = mock('response', :body=)
    route_params = {}
    @context = Sinatra::EventContext.new(request, response, route_params)
  end

  test 'url_for' do
    assert_equal '/Foo%20Bar', @context.url_for("Foo Bar")
    assert_equal '/Foo/Bar', @context.url_for("Foo", "Bar")
    assert_equal '/library/Foo/Bar/test.mp3', @context.url_for('Foo', 'Bar', 'test.mp3')
  end
  
  test 'get_entries alpha sorts results' do
    Dir.expects(:entries).returns(['c', 'b', 'a'])
    assert_equal 'a', @context.get_entries('/').first
  end
  
  test 'get_entries removes dotfiles' do
    Dir.expects(:entries).returns(['a', '.a', '.', '..'])
    entries = @context.get_entries('/')
    assert_equal 1, entries.size
    assert_equal ['a'], entries
    assert_nil entries.find {|e| e =~ /^\./ }
  end
  
  test 'get_entries not found' do
    # It should redirect if a path is not found
    # @context.get_entries(MUSIC_BASE + '/Nothing')
  end
  
  test 'get_mp3' do
    assert_equal 'Hello world', @context.get_mp3(MUSIC_BASE + '/Foo/Bar/test.mp3')
    # halt if 404
  end
  
  test 'title for index' do
    @context.request.expects(:params).returns({'splat' => ['']})
    assert_equal 'MUSIC', @context.title
  end
  
  test 'title for music path' do
    @context.request.expects(:params).returns({'splat' => ['Foo']})
    assert_equal ['Foo'], @context.title
  end
  
  test 'title for artist album music path' do
    @context.request.expects(:params).returns({'splat' => ['Foo/Bar']})
    assert_equal ['Foo/Bar'], @context.title
  end
end