# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fluent/plugin/threshold/version'

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-threshold"
  spec.version       = Fluent::Plugin::Threshold::VERSION
  spec.authors       = ["moulin"]
  spec.email         = ["yoshimura-takuya@kayac.com"]

  spec.summary       = %q{fluent plugin to filter each log record by the threshold.}
  spec.description   = %q{fluent plugin to filter each log record by the threshold.}
  spec.homepage      = "https://github.com/takyoshi/fluent-plugin-threshold"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "fluentd", ">= 0.10.0"
  spec.add_runtime_dependency "test-unit", ">= 0.10.0"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
