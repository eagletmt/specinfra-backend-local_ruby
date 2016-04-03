# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'specinfra/local_ruby_backend/version'

Gem::Specification.new do |spec|
  spec.name          = 'specinfra-backend-local_ruby'
  spec.version       = Specinfra::LocalRubyBackend::VERSION
  spec.authors       = ['Kohei Suzuki']
  spec.email         = ['eagletmt@gmail.com']

  spec.summary       = 'Specinfra backend for local using Ruby'
  spec.description   = 'Specinfra backend for local using Ruby'
  spec.homepage      = 'https://github.com/eagletmt/specinfra-backend-local_ruby'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_dependency 'specinfra'
end
