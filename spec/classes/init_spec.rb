require 'spec_helper'
describe 'st' do

  context 'with defaults for all parameters' do
    it { should contain_class('st') }
  end
end
