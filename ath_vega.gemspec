# frozen_string_literal: true

require_relative "lib/ath_vega/version"

Gem::Specification.new do |spec|
  spec.name          = "ath_vega"
  spec.version       = AthVega::VERSION
  spec.authors       = ["Ahmaud R. Templeton"]
  spec.email         = ["ahmaud@gmail.com"]

  spec.summary       = "workout planner."
  spec.description   = "Ath helps you plan your workout using exercises from the open source app, 'wger'."
  spec.homepage      = "https://github.com/ahmaudt/flatiron-cli-data-gem"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ahmaudt/flatiron-cli-data-gem"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_development_dependency "rspec", "~> 2.4"
  spec.add_dependency "nokogiri"
  spec.add_dependency "net-http"
  spec.add_dependency "uri"
  spec.add_dependency "awesome_print"
  spec.add_dependency "json"
  spec.add_dependency "require_all"
  spec.add_dependency "pry"
  spec.add_dependency "tty-option"
  spec.add_dependency "tty-progressbar"
  spec.add_dependency "tty-prompt"
  spec.add_dependency "tco"
  spec.add_dependency "rmagick"
  spec.add_dependency "catpix"
  spec.add_dependency "tty-table"

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
