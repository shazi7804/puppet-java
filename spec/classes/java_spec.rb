require 'spec_helper'

describe 'java', :type => 'class' do
  context 'with defaults for all parameters' do
    let(:facts) do
      { 
        :os => { :family => 'Debian', :name => 'Ubuntu', :release => { :major => '16.04', :full => '16.04' }},
        :lsbdistrelease  => '16.04',
        :lsbdistid       => 'Ubuntu',
        :osfamily        => 'Debian',
        :lsbdistcodename => 'xenial',
      }
    end
    it do
      should contain_class('java')
      should contain_class('java::config')
    end

    it do
      should compile.with_all_deps
    end
  end
end

#   let(:facts) do
#   {
#     :osfamily => 'Redhat',
#   }
#   end
#   # context 'select OpenJDK 1.8 for Ubuntu Xenial (16.04)' do
#   #   let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Ubuntu', :lsbdistcodename => 'xenial', :operatingsystemrelease => '16.04', :architecture => 'amd64',} }
#   #   it { is_expected.to contain_package('java').with_name('openjdk-8-jre') }
#   #   it { is_expected.to contain_augeas('java-home-environment').with_line('JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64') }
#   # end
  
#   #   context 'select Oracle JDK 1.8 for Ubuntu Xenial (16.04)' do
#   #   let(:facts) { {:osfamily => 'Debian', :operatingsystem => 'Ubuntu', :lsbdistcodename => 'xenial', :operatingsystemrelease => '16.04', :architecture => 'amd64',} }
#   #   let(:params) { { 'jdk_type' => 'oraclejdk', } }
#   #   it { is_expected.to contain_package('java').with_name('oracle-java8-installer') }
#   #   it { is_expected.to contain_augeas('java-home-environment').with_line('JAVA_HOME=/usr/lib/jvm/java-8-oracle') }
#   # end

#   #     context 'select Oracle JDK 1.8 for CentOS 6.3' do
#   #   let(:facts) { {:osfamily => 'Redhat', :operatingsystem => 'CentOS', :operatingsystemrelease => '6.3', :architecture => 'x86_64',} }
#   #   let(:params) { { 'jdk_type' => 'oraclejdk', } }
#   #   it { is_expected.to contain_package('java').with_name('jdk1.8.0_131') }
#   #   it { is_expected.to contain_augeas('java-home-environment').with_line('JAVA_HOME=/usr/java/default') }
#   # end

