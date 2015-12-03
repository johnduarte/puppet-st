require 'spec_helper_acceptance'

describe 'st class' do
  it "applies idempotently" do
    pp = "include st"
    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp)
  end
  describe file("/usr/local/bin/st") do
    it { should be_file }
  end
end
