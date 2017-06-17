# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sidekiq/cancellable_worker'

Gem::Specification.new do |spec|
  spec.name          = "sidekiq-cancellable-worker"
  spec.version       = Sidekiq::CancellableWorker::VERSION
  spec.authors       = ["Léonard Hetsch"]
  spec.email         = ["leo.hetsch@gmail.com"]

  spec.summary       = %q{Cancel Sidekiq workers at runtime}
  spec.homepage      = "https://github.com/OnceApp/sidekiq-cancellable-worker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "sidekiq"
end
