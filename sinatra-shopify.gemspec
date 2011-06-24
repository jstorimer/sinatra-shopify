Gem::Specification.new do |s|
  s.name = 'sinatra-shopify'
  s.version = '1.0.0'

  s.summary     = "A classy shopify_app"
  s.description = "A Sinatra extension for working with the Shopify API. Akin to the shopify_app gem but for Sinatra"

  s.authors = ["Jesse Storimer"]
  s.email = "jesse@gmail.com"
  s.homepage = "https://github.com/jstorimer/sinatra-shopify/"

  s.files = Dir.glob('lib/**/*.rb')
  s.files += ['README.md', 'LICENSE', 'sinatra-shopify.gemspec']

  s.add_dependency 'sinatra',     '~> 1.0'
  s.add_dependency 'shopify_api', '~> 1.2'
end

