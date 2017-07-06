# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "markdown_formatter/version"

Gem::Specification.new do |spec|
  spec.name          = "markdown_formatter"
  spec.version       = MarkdownFormatter::VERSION
  spec.authors       = ["siman-man"]
  spec.email         = ["k128585@ie.u-ryukyu.ac.jp"]

  spec.summary       = %q{markdown formatter}
  spec.description   = %q{markdown formatter}
  spec.homepage      = "https://github.com/yasslab/markdown_formatter"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "kramdown", "~> 1.14.0"
  spec.add_runtime_dependency "activesupport", "~> 5.1.2"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
