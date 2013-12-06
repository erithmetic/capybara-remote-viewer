require 'sinatra/base'
require 'haml'
require 'json'
require 'time'

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
          Dir.glob File.join(Server.path, '**/*.html')
        end

        def file(id)
          files.find { |f| f =~ /#{id}.html$/ }
        end

        def file_path(str)
          "/files/#{file_name(str)}"
        end

        def file_name(str)
          File.basename(str, '.html')
        end

        def file_date(str)
          filename = file_name(str)
          prefix, date_str = filename.split('-')
          if prefix == 'capybara'
            time = Time.parse date_str[0..13]
            ms = date_str[14..-1]
            time.strftime("%Y/%m/%d - %H:%M:%S.#{ms}")
          else
            filename
          end
        end

        get '/' do
          haml :index, locals: { dir: Server.path, files: files }
        end

        get '/files' do
          headers 'Content-Type' => 'application/json'

          list = files.map do |file|
            { name: file_date(file), url: file_path(file) }
          end

          { files: list }.to_json
        end

        get '/files/:id' do
          File.read file(params['id'])
        end
      end
    end
  end
end
