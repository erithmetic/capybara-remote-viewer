require 'thor'

module Capybara
  module Remote
    module Viewer
      class CLI < Thor

        desc 'serve', 'Run the web server'
        method_option :path, type: :string, default: nil, aliases: '-t'
        method_option :port, type: :numeric, default: 3000, aliases: '-p'
        def serve
          path = options.path || File.join(Dir.pwd, 'tmp')

          require 'capybara/remote/viewer/server'

          Capybara::Remote::Viewer::Server.path = path
          Capybara::Remote::Viewer::Server.set :port, options.port
          Capybara::Remote::Viewer::Server.run!
        end

        default_task :serve
      end
    end
  end
end
