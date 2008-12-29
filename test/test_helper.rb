require 'rubygems'
require File.join(File.dirname(__FILE__), '..', 'lib', 'sinatra_uri_char_fix')
require 'sinatra'
require 'sinatra/test/unit'
require 'test/unit'
require File.join(File.dirname(__FILE__), '..', 'init')

Sinatra::Application.default_options.merge!(
  :env => :test,
  :run => false,
  :raise_errors => true,
  :logging => false
)

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