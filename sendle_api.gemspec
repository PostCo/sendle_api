# frozen_string_literal: true
require_relative "lib/sendle_api/version"

Gem::Specification.new do |spec|
  spec.name = "sendle_api"
  spec.version = SendleAPI::VERSION
  spec.authors = ["Andy Chong"]
  spec.email = ["andygg1996personal@gmail.com"]

  spec.summary = "Ruby object based Sendle API wrapper."
  spec.homepage = "https://github.com/PostCo/sendle_api"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/PostCo/sendle_api"
  spec.metadata["changelog_uri"] = "https://github.com/PostCo/sendle_api/releases"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    %x(git ls-files -z).split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency("activeresource", ">= 4.1.0")
  spec.add_dependency("countries", "~> 3.0")
  spec.add_dependency("phonelib", "~> 0.6")

  spec.add_development_dependency("rspec", "~> 3.2")
  spec.add_development_dependency("dotenv")
  spec.add_development_dependency("pry-byebug")
  spec.add_development_dependency("pry")
  spec.add_development_dependency("guard-rspec")
  spec.add_development_dependency("rubocop")
  spec.add_development_dependency("rubocop-shopify")
  spec.metadata["rubygems_mfa_required"] = "true"
end
