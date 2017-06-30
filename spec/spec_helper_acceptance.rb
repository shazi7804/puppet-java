# require 'beaker-rspec'
# require 'beaker/puppet_install_helper'
# require 'beaker/module_install_helper'

# run_puppet_install_helper
# install_module_on(hosts)
# install_module_dependencies_on(hosts)

# UNSUPPORTED_PLATFORMS = [ "Darwin", "windows" ]

# unless ENV["RS_PROVISION"] == "no" or ENV["BEAKER_provision"] == "no"
#   hosts.each do |host|
#     install_puppet_module_via_pmt_on(host, {module_name: 'puppetlabs-apt'})
#   end
# end

# RSpec.configure do |c|
#   # Readable test descriptions
#   c.formatter = :documentation
# end

require 'beaker-rspec'
require 'pry'

step "Install Puppet on each host"
install_puppet_agent_on( hosts, { :puppet_collection => 'pc1' } )

RSpec.configure do |c|
  # Find the module directory
  module_root = File.expand_path( File.join( File.dirname(__FILE__), '..') )
  
  # Enable test descriptions
  c.formatter = :documentation
  
  # Configure all nodes in nodeset
  c.before :suite do

    # Install module and dependencies
    puppet_module_install(
      :source      => module_root,
      :module_name => 'java', 
    )

    hosts.each do |host|
      # Install dependency modules
      on host, puppet('module', 'install', 'puppetlabs-stdlib'),
        { :acceptable_exit_codes => [0,1] }
    end
  end
end