# frozen_string_literal: true

require_relative "lib/bookmeter_exporter/version"

Gem::Specification.new do |spec|
  spec.name          = "bookmeter_exporter"
  spec.version       = BookmeterExporter::VERSION
  spec.authors       = ["Ikuo Degawa"]
  spec.email         = ["degawa@ikuwow.com"]

  spec.summary       = "Export user history of bookmeter.com"
  spec.homepage      = "https://ikuwow.github.io/bookmeter_exporter/"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ikuwow/bookmeter_exporter"
  spec.metadata["changelog_uri"] = "https://github.com/ikuwow/bookmeter_exporter/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "selenium-webdriver", "~> 3.142.2"
end
