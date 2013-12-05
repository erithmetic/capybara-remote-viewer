require 'thor'

module Capybara
  module Remote
    module Viewer
      class CLI < Thor
        method_option :port, type: :numeric, default: 3000, aliases: '-p'
        desc 'serve', 'Run the web server'
        def serve
          require 'capybara/remote/viewer/server'
          Capybara::Remote::Viewer::Server.set :port, options.port
          Capybara::Remote::Viewer::Server.run!
        end

        default_task :serve
      end
    end
  end
end
