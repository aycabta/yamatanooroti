# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yamatanooroti/version'

Gem::Specification.new do |spec|
  spec.name          = 'yamatanooroti'
  spec.version       = Yamatanooroti::VERSION
  spec.authors       = ['aycabta']
  spec.email         = ['aycabta@gmail.com']

  spec.summary       = %q{Multi-platform real(?) terminal test framework}
  spec.description   = <<-EOD
    Yamatanooroti is a multi-platform real(?) terminal test framework.
  EOD
  spec.homepage      = 'https://github.com/aycabta/yamatanooroti'
  spec.license       = 'MIT'

  spec.files         = Dir['LICENSE.txt', 'README.md', 'lib/**/*']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = Gem::Requirement.new('>= 2.5')

  spec.add_dependency 'test-unit'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
