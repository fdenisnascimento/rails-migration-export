# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require './lib/migration_export/version'

Gem::Specification.new do |spec|
  spec.name          = 'migration-export'
  spec.version       = MigrationExport::Version::STRING
  spec.authors       = ['Denis Nascimento', 'Magno Costa']
  spec.email         = ['denis@thssolution.com', 'magnocosta.br@gmail.com']
  spec.description = spec.summary = 'Migration Export is a helper to export migration to sql file'
  spec.homepage      = 'https://github.com/fdnascimento/rails-migration-export'

  spec.files         = Dir['{lib/**/*.rake,lib/**/*.rb,README.rdoc,spec/**/*.rb,Rakefile,*.gemspec}']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'pry', '~> 0'
end
