require 'spec_helper_acceptance'

environment = '/etc/environment'

case fact('osfamily')
when 'Debian'
  package_name = 'openjdk-8-jre'
  java_home = '/usr/lib/jvm/java-8-openjdk-amd64'
when 'RedHat'
  package_name = 'java-1.8.0-openjdk'
  java_home = '/usr/lib/jvm/jre-1.8.0-openjdk.x86_64'
end

describe 'install java' do
  context 'default parameters with OpenJDK 1.8' do
    it 'should install package' do
      pp = "class { 'java': }"

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  
    describe package(package_name) do
      it { should be_installed }
    end

    describe file(environment) do
      its(:content) { should match("JAVA_HOME=#{java_home}") }
    end
  end

  context 'default parameters with OpenJDK 1.7' do
    it 'should install package' do
      pp = "class { 'java': jdk_version => '7' }"

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  
    describe package(package_name) do
      it { should be_installed }
    end

    describe file(environment) do
      its(:content) { should match("JAVA_HOME=#{java_home}") }
    end
  end
end