# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sentence_builder/version'

Gem::Specification.new do |spec|
  spec.name          = "sentence_builder"
  spec.version       = SentenceBuilder::VERSION
  spec.authors       = ["Emin Bugra Saral"]
  spec.email         = ["eminbugrasaral@me.com"]
  spec.summary       = %q{Sentence Builder}
  spec.description   = %q{Build your dynamic sentences by connecting customizable nodes}
  spec.homepage      = "https://github.com/eminbugrasaral/sentence-builder"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.4"
  spec.add_development_dependency "rake", "~> 13.0"
end
