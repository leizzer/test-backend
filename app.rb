require 'roda'
require 'sequel'
require 'wedge'
require_relative 'app/lib/shield_methods'

class TestApp < Roda
  plugin :environments
  plugin :multi_route
  plugin :empty_root

  use Rack::Session::Cookie, key: 'rack.session', secret: 'my_little_secret'

  plugin ::ShieldMethods

  configure :development do
    require 'pry'
    require 'awesome_print'
  end

  plugin :wedge,
    scope: self,
    skip_call_middleware: true,
    assets_url: "/assets/wedge/wedge",
    plugins: [:form],
    gzip_assets: true

  plugin :sprocket_assets,
    root:        Dir.pwd,
    public_path: "#{Dir.pwd}/public",
    prefix:      %w`app/ app/assets public/assets bower_components/`,
    debug:       development?,
    opal:        true

  configure :development do
    require 'better_errors'

    # Include middlware
    use BetterErrors::Middleware

    # Show better errors for any ip
    BetterErrors::Middleware.allow_ip! "0.0.0.0/0"
  end

  route do |r|
    # Load the todo app
    r.root do
      if current_user
        wedge(:todo).to_js :display
      else
        r.redirect '/login'
      end
    end

    r.on 'api' do
      r.run Api
    end

    # Handles wedge calls
    r.wedge_assets
    # Handles all assets
    r.sprocket_assets
    # https://github.com/jeremyevans/roda/blob/master/lib/roda/plugins/multi_route.rb
    r.multi_route
  end

end

# Path to project folders
GLOB = "**/{lib,config,routes,models,forms,components}/*.rb"

# Load folders
Dir[GLOB].each { |file| require_relative file }
