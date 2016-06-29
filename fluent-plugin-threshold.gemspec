# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fluent/plugin/threshold/version'

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-threshold"
  spec.version       = Fluent::Plugin::Threshold::VERSION
  spec.authors       = ["moulin"]
  spec.email         = ["yoshimura-takuya@kayac.com"]

  spec.summary       = %q{fluent-plugin-threshold is the simple filter using a threshold.}
  spec.description   = %q{fluent-plugin-threshold filters input by a numeric threshold, and filtered record passes into output as it is.}
  spec.homepage      = "https://github.com/takyoshi/fluent-plugin-threshold"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "fluentd", "~> 0.10.0"
  spec.add_runtime_dependency "test-unit", "~> 3.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 0.9"
end
