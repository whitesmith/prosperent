# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prosperent/version'

Gem::Specification.new do |spec|
  spec.name          = "prosperent"
  spec.version       = Prosperent::VERSION
  spec.authors       = ["João Barbosa"]
  spec.email         = ["j.barbosa333@gmail.com"]
  spec.summary       = %q{Ruby on Rails wrapper gem for Prosperent API}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
