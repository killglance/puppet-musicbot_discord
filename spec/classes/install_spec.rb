require 'spec_helper'

describe 'musicbot_discord::install' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      precondition = <<-END
class { 'musicbot_discord': }
      END
      let(:pre_condition) { precondition }
      context 'with default parameters' do
        it { is_expected.to contain_class('musicbot_discord::repos') }

        [
            'build-essential',
            'ffmpeg',
            'libopus-dev',
            'libffi-dev',
            'libsodium-dev',
            'unzip',
        ].each do |pkg|
          it { is_expected.to contain_package(pkg) }
        end
        case facts[:lsbdistcodename]
          when 'trusty'
            [
                'python',
                'python3.5-dev',
                'software-properties-common',
            ].each do |pkg|
              it { is_expected.to contain_package(pkg) }
            end
          when 'xenial'
            it { is_expected.to contain_package('python3-pip') }
          else
            # unsupported OS
        end
      end
    end
  end
end