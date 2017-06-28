require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'
 
run_puppet_install_helper
install_module_on(hosts)
install_module_dependencies_on(hosts)

UNSUPPORTED_PLATFORMS = [ "Darwin", "windows" ]
 
RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
 
  c.formatter = :documentation
 
  c.before :suite do
    hosts.each do |host|
      copy_module_to(host, :source => proj_root, :module_name => 'java')
      on host[0], puppet('module install puppetlabs-apt'),
        {:acceptable_exit_codes => [0]}
    end
  end
end
