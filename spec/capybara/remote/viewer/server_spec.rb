require 'spec_helper'
require 'rack/test'
require 'capybara/remote/viewer/server'

describe Capybara::Remote::Viewer::Server do
  include Rack::Test::Methods

  before(:all) do
    Capybara::Remote::Viewer::Server.
      set :path, File.expand_path('../../../../dummy', __FILE__)
  end

  def app
    Capybara::Remote::Viewer::Server
  end

  describe 'GET /' do

    it 'links to existing files' do
      get '/'

      last_response.body.should =~ %r{<a href='/files/1' target='porthole'>1</a>}
    end
    
  end

  describe 'GET /files/1' do

    it 'displays the content of a capybara dump' do
      get '/files/1'

      last_response.body.should =~ %r{First dump}
    end

  end

  describe '#file_date' do

    let(:server) { app.new.instance_variable_get(:@instance) }

    it 'parses a capybara file name as a date string' do
      server.
        file_date('/path/to/app/tmp/capybara/capybara-201312061034395395175534.html').
        should == '2013/12/06 - 10:34:39.5395175534'
    end

    it "just returns a string if it doesn't match standard capy file name" do
      server.
        file_date('/path/to/app/tmp/foo/bar.html').
        should == 'bar'
    end

  end

end

