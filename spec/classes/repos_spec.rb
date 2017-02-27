require 'spec_helper'

describe 'musicbot_discord::repos' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      precondition = <<-END
class { 'musicbot_discord': }
      END
      let(:pre_condition) { precondition }

      context 'with default parameters' do
        it { is_expected.to contain_class('apt') }

        case facts[:lsbdistcodename]
          when 'trusty'
            [
                'ppa:fkrull/deadsnakes',
                'ppa:mc3man/trusty-media',
                'ppa:chris-lea/libsodium',
            ].each do |ppa|
              it "should have ppa #{ppa} that requires software-properties-common" do
                is_expected.to contain_apt__ppa(ppa).that_requires('Package[software-properties-common]')
              end
            end
            it { is_expected.to contain_package('software-properties-common').with_ensure('present') }
          when 'xenial'
            it { is_expected.to contain_apt__ppa('ppa:mc3man/xerus-media') }
          else
            # pass
        end

      end
    end
  end

end