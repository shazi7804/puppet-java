require 'spec_helper_acceptance'

describe 'install java' do
  context 'default parameters' do
    let(:facts) { { :osfamily => 'Debian' } }
    it 'should work with no errors' do
      pp = <<-EOS
        class { 'java': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  
    describe package('java') do
      it { should be_installed }
    end
  end
end