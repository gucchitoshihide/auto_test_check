# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require File.expand_path('../lib/cert/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "cert"
  spec.version       = Cert::VERSION
  spec.authors       = ["Yusuke Matsukawa"]
  spec.email         = ["mat27y@gmail.com"]
  spec.summary       = %q{Certificate user action}
  spec.description   = %q{Certificate user action}
  spec.homepage      = "https://github.com/mat5ukawa/Las"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
end
