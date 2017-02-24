source ENV['GEM_SOURCE'] || 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : ['~> 3.8']

group :test do
  gem 'puppet', puppetversion, :require => false
  gem 'puppetlabs_spec_helper', '~> 2.0.1', :require => false
  gem 'parallel_tests', :require => false
  gem 'rspec-puppet', '~> 2.5', :require => false
  gem 'rspec-puppet-facts', :require => false
  gem 'rspec-puppet-utils', :require => false
  gem 'puppet-lint-absolute_classname-check', :require => false
  gem 'puppet-lint-leading_zero-check', :require => false
  gem 'puppet-lint-trailing_comma-check', :require => false
  gem 'puppet-lint-version_comparison-check', :require => false
  gem 'puppet-lint-classes_and_types_beginning_with_digits-check', :require => false
  gem 'puppet-lint-unquoted_string-check', :require => false
  gem 'puppet-lint-variable_contains_upcase', :require => false
  gem 'metadata-json-lint', :require => false
  gem 'puppet-blacksmith', :require => false
  gem 'mocha', '>= 1.2.1', :require => false
  gem 'simplecov-console', :require => false
  gem 'github_changelog_generator', '~> 1.13.0', :require => false
  gem 'rack', '~> 1.0', :require => false if RUBY_VERSION < '2.2.2'
end

group :development do
  gem 'travis', :require => false
  gem 'travis-lint', :require => false
  gem 'guard-rake', :require => false
end

group :system_tests do
  gem 'beaker', '< 3.0', :require => false
  gem 'beaker-rspec', :require => false
  gem 'serverspec', :require => false
  gem 'beaker-puppet_install_helper', :require => false
end
