require 'spec_helper'
describe 'musicbot_discord' do
  context 'with default values for all parameters' do
    it { should contain_class('musicbot_discord') }
  end
end
