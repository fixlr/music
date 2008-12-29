module Sinatra
  class Event
    URI_CHAR = '[^/?:,#\.]'.freeze unless defined?(URI_CHAR)
  end
end
