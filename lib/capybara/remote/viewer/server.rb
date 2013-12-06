require 'sinatra/base'
require 'haml'
require 'json'

module Capybara
  module Remote
    module Viewer
      class Server < Sinatra::Base

        def self.path
          @path
        end
        def self.path=(val)
          @path = val
        end

        set :views, File.expand_path('../../../../../views', __FILE__)
        set :public_folder, File.expand_path('../../../../../static', __FILE__)

        def files
          Dir.glob File.expand_path('../tmp/capybara/*.html', __FILE__)
        end

        def file(id)
          files.find { |f| f =~ /#{id}$/ }
        end

        get '/' do
          haml :index, locals: { dir: Dir.pwd }
        end

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
