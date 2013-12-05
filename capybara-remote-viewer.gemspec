# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capybara/remote/viewer/version'

Gem::Specification.new do |spec|
  spec.name          = "capybara-remote-viewer"
  spec.version       = Capybara::Remote::Viewer::VERSION
  spec.authors       = ["Derek Kastner"]
  spec.email         = ["dkastner@gmail.com"]
  spec.description   = %q{View capybara page dumps remotely}
  spec.summary       = %q{A web server that looks for capybara's saved output and makes them available to remotely connected developers}
  spec.homepage      = "http://github.com/dkastner/capybara-remote-viewer"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'haml'
  spec.add_dependency 'sinatra'
  spec.add_dependency 'thor'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
