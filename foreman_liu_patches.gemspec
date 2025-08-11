# frozen_string_literal: true

require_relative 'lib/foreman_liu_patches/version'

Gem::Specification.new do |spec|
  spec.name          = 'foreman_liu_patches'
  spec.version       = ForemanLiuPatches::VERSION
  spec.authors       = ['Alexander Olofsson']
  spec.email         = ['alexander.olofsson@liu.se']

  spec.summary       = 'Patches for the Linköping University Foreman instance'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/ananace/foreman_liu_patches'
  spec.license       = 'GPL-3.0'

  spec.files         = Dir['{app,lib}/**/*'] + %w[LICENSE.txt Rakefile README.md]

  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-minitest'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rails'
end
