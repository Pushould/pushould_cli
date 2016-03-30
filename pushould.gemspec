# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pushould/version'

Gem::Specification.new do |spec|
  spec.name          = "pushould"
  spec.version       = Pushould::VERSION
  spec.authors       = ["Yu Hoshino"]
  spec.email         = ["yhoshino11@gmail.com"]

  spec.summary       = %q{Pushould Command Line Interface}
  spec.description   = %q{Pushould Command Line Interface}
  spec.homepage      = "https://pushould.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_dependency "rest-client"
  spec.add_dependency "json"
  spec.add_dependency "thor"
end
