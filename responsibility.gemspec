
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "responsibility/version"

Gem::Specification.new do |spec|
  spec.name          = "responsibility"
  spec.version       = Responsibility::VERSION
  spec.authors       = ["Erick Brower"]
  spec.email         = ["cerickbrower@gmail.com"]

  spec.summary       = %q{Provides an interface for creating single purpose objects}
  spec.description   = <<~HEREDOC
    A Responsibility is a class that provides a single piece of functionality,
    as per the Single Responsibility Principle
    [https://en.wikipedia.org/wiki/Single_responsibility_principle]. This class
    provides a single method called "perform", with optional "before" and
    "after" hooks.
    HEREDOC
  spec.homepage      = "http://github.com/erickbrower/responsibility"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16.a"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry-byebug", "~> 3.5"
end
