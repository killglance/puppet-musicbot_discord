require 'spec_helper'

describe 'musicbot_discord' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      context 'with default values for all parameters' do
        [
            'musicbot_discord',
            'musicbot_discord::params',
            'musicbot_discord::install',
            'musicbot_discord::service',
            'stdlib',
        ].each do |cls|
          it { is_expected.to contain_class(cls) }
        end
        it { is_expected.to contain_class('musicbot_discord::config').that_requires('Class[musicbot_discord::install]') }
        it { is_expected.to contain_class('musicbot_discord::service').that_subscribes_to('Class[musicbot_discord::config]') }
        end
    end
  end

end
