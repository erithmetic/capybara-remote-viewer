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

      last_response.body.should =~ %r{<a href='/files/1'>1</a>}
    end
    
  end

  describe 'GET /files/1' do

    it 'displays the content of a capybara dump' do
      get '/files/1'

      last_response.body.should =~ %r{First dump}
    end

  end

end

