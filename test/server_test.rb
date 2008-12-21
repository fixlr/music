require 'rubygems'
require 'sinatra'
require 'sinatra/test/unit'
require 'test/unit'
require File.dirname(__FILE__) + '/../server'

class Test::Unit::TestCase
  def self.test(name, &block)
    test_name = "test_#{name.gsub(/\s+/,'_')}".to_sym
    defined = instance_method(test_name) rescue false
    raise "#{test_name} is already defined in #{self}" if defined
    if block_given?
      define_method(test_name, &block)
    else
      define_method(test_name) do
        flunk "No implementation provided for #{name}"
      end
    end
  end
end

class MusicServerTest < Test::Unit::TestCase
  test 'get on /' do
    get_it '/'
    assert_equal 200, @response.status
    assert_equal 'Foo', @response.body
  end
  
  test 'get on /artist' do
    get_it '/Foo'
    assert_equal 200, @response.status
    assert_equal 'Bar', @response.body
  end
  
  test 'get on /artist does not exist' do
    get_it '/nobody'
    # assert_redirected '/'
    assert_equal 302, @response.status
    assert_equal '/', @response.headers['Location']
    assert_equal '', @response.body
  end
  
  test 'get on /artist/album' do
    get_it '/Foo/Bar'
    assert_equal 200, @response.status
    assert_equal 'test.mp3', @response.body
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
end