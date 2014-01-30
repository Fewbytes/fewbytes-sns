# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fewbytes/sns/version'

Gem::Specification.new do |spec|
  spec.name          = "fewbytes-sns"
  spec.version       = Fewbytes::Sns::VERSION
  spec.authors       = ["Alex SHD"]
  spec.email         = ["alex@fewbytes.com"]
  spec.summary       = %q{CMD for sending aws sns messeges.}
  spec.description   = %q{CMD for sending aws sns messeges to distrebuted systems.}
  spec.homepage      = "http://www.fewbytes.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "aws-sdk"
end
