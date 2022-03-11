# frozen_string_literal: true

require_relative 'lib/trip_trails/version'

Gem::Specification.new do |spec|
  spec.name = 'trip_trails'
  spec.version = TripTrails::VERSION
  spec.authors = ['AlejandroFernandesAntunes']
  spec.email = ['aantunes70@hotmail.com']

  spec.summary = 'TripTrail records on your project'
  spec.description = 'Record every step of the process when analyzing trip triggers.'
  spec.homepage = 'https://github.com/grapevinetravel/trip_trails'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/grapevinetravel/trip_trails'
  spec.metadata['changelog_uri'] = 'https://github.com/grapevinetravel/trip_trails'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
