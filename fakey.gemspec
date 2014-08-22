# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fakey/version'

Gem::Specification.new do |spec|
  spec.name          = "fakey"
  spec.version       = Fakey::VERSION
  spec.authors       = ["Sava Chankov"]
  spec.email         = ["sava@tutuf.com"]
  spec.description   = %q{Foreign keys support for ActiveRecord migrations}
  spec.summary       = %q{Foreign keys support for ActiveRecord migrations}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", "~>3.2.18"

  spec.add_development_dependency "rails", "~>3.2.18"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
