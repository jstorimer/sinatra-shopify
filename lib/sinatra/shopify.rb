require 'sinatra/base'
require 'shopify_api'

module Sinatra
  module Shopify

    module Helpers
      def current_shop
        session[:shopify]
      end

      def authorize!
        redirect '/login' unless current_shop

        ShopifyAPI::Base.site = session[:shopify].site
      end

      def logout!
        session[:shopify] = nil
      end
    end

    def self.registered(app)
      app.helpers Shopify::Helpers
      app.enable :sessions

      app.template :login do
        <<-SRC
        <h1>Login</h1>

        <p>
          First you have to register this app with a shop to allow access to its private admin data.
        </p>

        <form action='/login/authenticate' method='post'>
          <label for='shop'><strong>The URL of the Shop</strong>
            <span class="hint">(or just the subdomain if it's at myshopify.com)</span>
          </label>
          <p>
            <input type='text' name='shop' />
          </p>
          <input type='submit' value='Authenticate' />
        </form>
          SRC
      end

      unless ENV['SHOPIFY_API_KEY'] && ENV['SHOPIFY_API_SECRET']
        puts "Set your Shopify api_key and secret via ENV['SHOPIFY_API_KEY'] and ENV['SHOPIFY_API_SECRET']"
      end
      ShopifyAPI::Session.setup(:api_key => ENV['SHOPIFY_API_KEY'], :secret => ENV['SHOPIFY_API_SECRET'])

      app.get '/login' do
        erb :login
      end
      
      app.get '/logout' do
        logout!
        redirect '/'
      end

      app.post '/login/authenticate' do
        redirect ShopifyAPI::Session.new(params[:shop]).create_permission_url
      end
      
      app.get '/login/finalize' do
        shopify_session = ShopifyAPI::Session.new(params[:shop], params[:t])
        if shopify_session.valid?
          session[:shopify] = shopify_session

          return_address = session[:return_to] || '/'
          session[:return_to] = nil
          redirect return_address
        else
          redirect '/login'
        end
      end
    end
  end

  register Shopify
end
