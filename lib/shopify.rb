require 'sinatra/base'

module Sinatra
  module Shopify

    module Helpers
      def current_shop
        session[:shopify]
      end

      def authorize!
        redirect '/login' unless current_shop
      end

      def logout!
        session[:shopify] = nil
      end
    end

    def self.registered(app)
      app.helpers Shopify::Helpers

      app.get '/login' do
        erb :login
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