# frozen_string_literal: true

require_relative "lib/replicate/version"

Gem::Specification.new do |spec|
  spec.name = "replicate-api"
  spec.version = Replicate::VERSION
  spec.authors = ["Olivia Li"]
  spec.email = ["oliviali.ouyang@gmail.com"]

  spec.summary = "Ruby API wrapper for Replicate"
  spec.homepage = "https://github.com/Olivia-li/replicate-ruby.git"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Olivia-li/replicate-ruby.git"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "faraday", "~> 2.7.1"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  
end
