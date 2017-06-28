require 'spec_helper'
describe 'java' do
  context 'select OpenJDK 1.8 for Ubuntu Xenial (16.04)' do
    let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Ubuntu', :lsbdistcodename => 'xenial', :operatingsystemrelease => '16.04', :architecture => 'amd64',} }
    it { is_expected.to contain_package('java').with_name('openjdk-8-jre') }
    it { is_expected.to contain_augeas('java-home-environment').with_line('JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64') }
  end
end
