# frozen_string_literal: true

require_relative "lib/ath_vega/version"

Gem::Specification.new do |spec|
  spec.name          = "ath_vega"
  spec.version       = AthVega::VERSION
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.authors       = ["Ahmaud R. Templeton"]
  spec.email         = ["ahmaud@gmail.com"]
  spec.summary       = "workout planner."
  spec.description   = "Ath helps you plan your workout using exercises from the open source app, 'wger'."
  spec.homepage      = "https://github.com/ahmaudt/ath_vega"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = 'http://rubygems.org'

  # spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata = { "source_code_uri" => "https://github.com/ahmaudt/ath_vega" }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_development_dependency "rspec", "~> 2.4"
  spec.add_dependency "nokogiri", "~> 1.11.1"
  spec.add_dependency "net-http", "~> 0.1.1"
  spec.add_dependency "uri", "~> 0.10.1"
  spec.add_dependency "awesome_print", "~> 1.8.0"
  spec.add_dependency "json", "~> 2.5.1"
  spec.add_dependency "require_all", "~> 3.0.0"
  spec.add_dependency "pry", "~> 0.14.0"
  spec.add_dependency "tty-progressbar", "~> 0.18.1"
  spec.add_dependency "tty-prompt", "~> 0.23.0"
  spec.add_dependency "tco", "~> 0.1.8"
  spec.add_dependency "rmagick", "~> 2.16.0"
  spec.add_dependency "catpix", "~> 0.2.0"
  spec.add_dependency "tty-table", "~> 0.12.0"

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
