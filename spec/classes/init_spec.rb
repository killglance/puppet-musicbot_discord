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

  context 'with bad parameters' do
    let(:facts) do
      {
          :lsbdistcodename => 'trusty',
      }
    end
    [:user,].each do |param|
      value = true
      context "#{param} => #{value}" do
        let(:params) do
          { param => value,}
        end
        it 'should fail' do
          is_expected.to compile.and_raise_error(/not a string/)
        end
      end
    end
    [:install_dir,].each do |param|
      value = 'this_is_not_an_abs'
      context "#{param} => #{value}" do
        let(:params) do
          { param => value,}
        end
        it 'should fail' do
          is_expected.to compile.and_raise_error(/not an absolute path/)
        end
      end
    end
  end

  context 'on unsupported OS' do
    let(:facts) do
      {
          :operatingsystem => 'el_broken',
          :opeatingsystemrelease => 'super_broken',
      }
    end
    it 'Should throw an unsupported error' do
      is_expected.to compile.and_raise_error(/Distribution not supported/)
    end
  end

end
