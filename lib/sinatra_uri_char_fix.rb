module Sinatra
  class Event
    # Removed the following:  & , . #
    URI_CHAR = '[^/?:]'.freeze unless defined?(URI_CHAR)
  end
end
