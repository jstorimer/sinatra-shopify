require 'rubygems'
require 'sinatra'

$:.unshift(File.dirname(__FILE__) + '/lib')
require 'sinatra/shopify'

get '/' do
  redirect '/home'
end

get '/home' do
  authorize!
  
  @products = ShopifyAPI::Product.find(:all, :params => {:limit => 3})
  @orders   = ShopifyAPI::Order.find(:all, :params => {:limit => 3, :order => "created_at DESC" })
  erb :index
end

get '/design' do
  erb :design
end