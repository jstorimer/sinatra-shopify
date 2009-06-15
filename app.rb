require 'rubygems'
require 'sinatra'
require 'sinatra/shopify'

get '/' do
  authorize!
  erb :index
end