require 'spec_helper_acceptance'

describe 'install java' do
  context 'default parameters with Oracle JDK 1.8' do
    it 'should install package' do
      pp = "class { 'java': jdk_type => 'oraclejdk' }"

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end

  context 'default parameters with Oracle JDK 1.7' do
    it 'should install package' do
      pp = "class { 'java': jdk_type => 'oraclejdk', jdk_version => '7' }"

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end
end