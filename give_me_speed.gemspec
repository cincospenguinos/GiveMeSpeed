require_relative 'lib/give_me_speed/version'

Gem::Specification.new do |spec|
  spec.name          = "give_me_speed"
  spec.version       = GiveMeSpeed::VERSION
  spec.authors       = ["Andre LaFleur"]
  spec.email         = ["cincospenguinos@gmail.com"]

  spec.summary       = %q{Speed test gem to get Comcast to respect what I'm paying.}
  spec.description   = %q{Comcast will sometimes give you less speed than what you're paying for, and this gem exists to get them to respect speed limits.}
  spec.homepage      = "http://www.github.com/cincospenguinos/give_me_speed"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "" # TODO: This

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://www.github.com/cincospenguinos/give_me_speed"
  spec.metadata["changelog_uri"] = "http://www.github.com/cincospenguinos/give_me_speed"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'speedtest'
end
