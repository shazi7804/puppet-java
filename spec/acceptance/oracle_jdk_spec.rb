require 'spec_helper_acceptance'

environment = '/etc/environment'

case fact('osfamily')
when 'Debian'
  package_name = 'oracle-java8-installer'
  java_home = '/usr/lib/jvm/java-8-oracle'
when 'RedHat'
  package_name = 'jdk1.8.0_131'
  java_home = '/usr/java/default'
end

describe 'install java' do
  context 'default parameters with OpenJDK' do
    it 'should install package' do
      pp = "class { 'java': jdk_type => 'oraclejdk' }"

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  
    describe package("#{package_name}") do
      it { should be_installed }
    end

    describe file("#{environment}") do
      its(:content) { should match("JAVA_HOME=#{java_home}") }
    end

  end
end