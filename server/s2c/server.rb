require 'rubygems'
require 'sinatra/base'
require_relative '../../lib/s2c'

module S2C
  class Server < Sinatra::Base  

    get "/hello" do
      "hello"
    end
    
  end
end

S2C::Server.run!