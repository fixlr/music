require File.join(File.dirname(__FILE__), 'test_helper')

class MusicHelpersTest < Test::Unit::TestCase
  before do
    request = mock('request')
    response = mock('response', :body => nil)
    route_params = mock('route_params')
    @event_context = Sinatra::EventContext.new(request, response, route_params)
  end

  test 'url_for artist' do
    puts @event_context.inspect
    assert_equal '/Foo', @event_context.url_for("Foo")
  end
end