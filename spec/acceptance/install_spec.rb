require 'spec_helper_acceptance'
 
describe 'install java', :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'should work with no errors' do
    pp = <<-EOS
      class { 'java': }
    EOS

    # Run it twice and test for idempotency
    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes => true)
  end
end