# frozen_string_literal: true

require_relative 'lib/leave_it/version'

Gem::Specification.new do |spec|
  spec.name          = 'leave_it'
  spec.version       = LeaveIt::VERSION
  spec.authors       = ['mykbren']
  spec.email         = ['myk.bren@gmail.com']

  spec.summary       = 'Injects pessimistic (~>) version constraints into your Gemfile from Gemfile.lock'
  spec.description = <<~DESC.strip
    CLI tool that scans Gemfile.lock and updates your Gemfile by adding pessimistic (~>) version
    constraints to unversioned gems.
  DESC
  spec.homepage      = 'https://github.com/mykbren/leave-it'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'
  spec.metadata['homepage_uri']     = spec.homepage
  spec.metadata['source_code_uri']  = spec.homepage
  spec.metadata['changelog_uri']    = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  # Includes all files tracked by git
  spec.files = Dir.glob('lib/**/*') + Dir.glob('bin/*') + ['README.md', 'CHANGELOG.md', 'LICENSE.txt',
                                                           'leave_it.gemspec']

  spec.bindir        = 'bin'
  spec.executables   = ['leave-it']
  spec.require_paths = ['lib']
end
