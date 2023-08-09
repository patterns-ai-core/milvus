# frozen_string_literal: true

require_relative "lib/milvus/version"

Gem::Specification.new do |spec|
  spec.name = "milvus"
  spec.version = Milvus::VERSION
  spec.authors = ["Andrei Bondarev"]
  spec.email = ["andrei.bondarev13@gmail.com"]

  spec.summary = "Ruby wrapper for the Milvus vector search database API"
  spec.description = "Ruby wrapper for the Milvus vector search database API"
  spec.homepage = "https://github.com/andreibondarev/milvus"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/andreibondarev/milvus"
  spec.metadata["changelog_uri"] = "https://github.com/andreibondarev/milvus/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "pry-byebug", "~> 3.10.0"
  spec.add_dependency "faraday", ">= 2.0.1", "< 3"
end
