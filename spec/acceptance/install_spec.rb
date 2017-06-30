require 'spec_helper_acceptance'

case fact('osfamily')
when 'Debian'
  packagename = 'openjdk-8-jre'
when 'RedHat'
  packagename = 'java-1.8.0-openjdk'
end

describe 'install java' do
  context 'default parameters with OpenJDK' do
    it 'should install package' do
      pp = "class { 'java': }"

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  
    describe package(packagename) do
      it { should be_installed }
    end
  end
end