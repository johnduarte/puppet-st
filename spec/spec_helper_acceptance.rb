require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'

run_puppet_install_helper

RSpec.configure do |c|
  # apache on Ubuntu 10.04 and 12.04 doesn't like IPv6 VirtualHosts, so we skip ipv6 tests on those systems
  if fact('operatingsystem') == 'Ubuntu' and (fact('operatingsystemrelease') == '10.04' or fact('operatingsystemrelease') == '12.04')
    c.filter_run_excluding :ipv6 => true
  end

  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # net-tools required for netstat utility being used by be_listening
    if fact('osfamily') == 'RedHat' && fact('operatingsystemmajrelease') == '7'
      pp = <<-EOS
        package { 'net-tools': ensure => installed }
      EOS

      apply_manifest_on(agents, pp, :catch_failures => false)
    end

    # Install module and dependencies
    hosts.each do |host|
      on host, puppet('module','install','puppetlabs-git')
      on host, puppet('module','install','puppetlabs-vcsrepo')
      copy_module_to(host, :source => proj_root, :module_name => 'st')
    end
  end
end
