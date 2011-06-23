Sinatra-Shopify: A classy shopify_app
====================================

This is a Sinatra extension that allows you to work with the "Shopify API":http://shopify.com/developers. It's basically just a port of the "shopify_app":http://github.com/Shopify/shopify_app rails plugin to sinatra.

== Why?

I have been "having fun working on Shopify apps":http://www.jstorimer.com/blogs/my-blog/1133402-shopify-api-extensions lately, but I needed a simpler way than always generating a new rails app, new controllers, etc., for every little idea.

Rails is great, but most of the "Shopify apps":http://apps.shopify.com that I have come up with are one page apps, maybe two or three pages. The point is, I don't need a controller for that, I don't need the 63 files or however many the rails generator generates for me.

Sinatra is most awesome when you are working on a small app with just a few routes. You can clone this app and use it as a starting point for a shopify_app. All of the authentication logic/routes are in the lib folder, so they don't pollute the code of your app.

So in app.rb, you just have to worry about the functionality of your app.

== Usage

Installable from rubygems as 'sinatra-shopify'.

The current implementation for authentication is to add the @authorize!@ method at the top of any routes that you want to be authenticated, like so:

```ruby
get '/sensitive_data' do
  authorize!
  
  # then do the sensitive stuff
end
```

Example
======

This repo includes an example Sinatra app. The fastest way to get it running:

* @git clone git://github.com/jstorimer/sinatra-shopify@
* @cd sinatra-shopify@
* @heroku create@ (make sure that you remember the name of your app as you will need that later)
* visit the "Shopify Partners area":http://app.shopify.com/services/partners
* Sign up for an account if you don't already have one
* Log in to your Shopify partners account
* Create a new application.
* Make sure that the Callback URL is set to http://_yourapp_.heroku.com/login/finalize
* In the lib/sinatra/shopify.yml file replace API_KEY and SECRET with the Api Key and Secret that you just got from the Shopify Partners area
* @git push heroku master@
* @heroku open@
