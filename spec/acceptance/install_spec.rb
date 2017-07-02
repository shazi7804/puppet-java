require 'spec_helper_acceptance'

environment = '/etc/environment'

case fact('osfamily')
when 'Debian'
  case jdk_version
  when '7'
    package_name = 'openjdk-7-jre'
    java_home = '/usr/lib/jvm/java-7-openjdk-amd64'
  when '8'
    package_name = 'openjdk-8-jre'
    java_home = '/usr/lib/jvm/java-8-openjdk-amd64'
  end
when 'RedHat'
  case jdk_version
  when '7'
    package_name = 'java-1.7.0-openjdk'
    java_home = '/usr/lib/jvm/jre-1.7.0-openjdk.x86_64'
  when '8'
    package_name = 'java-1.8.0-openjdk'
    java_home = '/usr/lib/jvm/jre-1.8.0-openjdk.x86_64'
  end
end

describe 'install java' do
  context 'default parameters with OpenJDK 1.8' do
    it 'should install package' do
      pp = "class { 'java': }"

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file(environment) do
      its(:content) { should match("JAVA_HOME=#{java_home}") }
    end
  end

  context 'default parameters with OpenJDK 1.7' do
    it 'should install package' do
      pp = "class { 'java': jdk_version => '7' }"

      if fact('osfamily') == 'Redhat'
        apply_manifest(pp, :expect_failures => true)
      else
        apply_manifest(pp, :catch_failures => true)
        apply_manifest(pp, :catch_changes => true)
      end
    end

    describe file(environment) do
      its(:content) { should match("JAVA_HOME=#{java_home}") }
    end
  end
end