require 'sinatra/base'
require 'haml'
require 'json'

module Capybara
  module Remote
    module Viewer
      class Server < Sinatra::Base
        set :views, File.expand_path('../views', __FILE__)

        def files
          Dir.glob File.expand_path('../tmp/capybara/*.html', __FILE__)
        end

        def file(id)
          files.find { |f| f =~ /#{id}$/ }
        end

        get '/' do
          haml :index, locals: { dir: Dir.pwd }
        end

        get '/application.js' do
          headers 'Content-Type' => 'text/javascript'
          File.read File.expand_path('../views/application.js', __FILE__)
        end

        get '/files' do
          headers 'Content-Type' => 'application/json'
          { files: files }.to_json
        end

        get '/files/:id' do
          File.read file(params[:id])
        end
      end
    end
  end
end
