module Sinatra
  module MyHelper
    include Rack::Utils
    alias_method :h, :escape_html

  end
end

