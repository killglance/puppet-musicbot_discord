require 'json'
require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

unless ENV['BEAKER_provision'] == 'no'
  hosts.each do |host|
    # Install Puppet
    if host.is_pe?
      install_pe
    else
      install_puppet
    end
  end
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    puppet_module_install(source: proj_root, module_name: 'musicbot_discord')
    hosts.each do |host|
      JSON.parse(File.read('metadata.json'))['dependencies'].each do |dependency|
        install_puppet_module_via_pmt_on(
            host,
            :module_name => dependency['name'],
            :version => dependency['version_requirement']
        )
      end
    end
  end
end