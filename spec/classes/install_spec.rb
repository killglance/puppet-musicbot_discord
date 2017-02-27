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
            'git',
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
            ].each do |pkg|
              it { is_expected.to contain_package(pkg) }
            end
          when 'xenial'
            it { is_expected.to contain_package('python3-pip') }
          else
            # Pass
        end

        it do
          user_parms = {
              :ensure => 'present',
              :comment => 'Musicbot user, created by Puppet',
              :managehome => true,
          }
          is_expected.to contain_user('musicbot').with(user_parms)
          inst_dir_params = {
              :ensure => 'directory',
              :mode => '0755',
              :owner => 'musicbot',
          }
          is_expected.to contain_file('/opt/musicbot').with(inst_dir_params)
          params = {
              :ensure => 'present',
              :path => '/opt/musicbot',
              :source => 'https://github.com/Just-Some-Bots/MusicBot.git',
              :provider => 'git',
              :revision => 'master',
              :user => 'musicbot',
              :require => 'File[/opt/musicbot]',
          }
          is_expected.to contain_vcsrepo('musicbot_repo').with(params)
        end

      end

      # No need to check custom parameters between OS's since it's user set
      if os['ubuntu-14.04-x86_64']
        context 'with custom paramters' do
          # $user
          {
              :user => 'discord',
          }.each do |k,v|
            context "#{k} => #{v}" do
              cust_param_precon = <<-END
class { 'musicbot_discord': #{k.to_s} => '#{v}', }
              END
              let(:pre_condition) { cust_param_precon }
              it do
                is_expected.to contain_user(v)
                is_expected.to contain_file('/opt/musicbot').with_owner(v)
                is_expected.to contain_vcsrepo('musicbot_repo').with_user(v)
              end

            end
          end

          # $install_dir
          {
              :install_dir => '/tmp/discord',
          }.each do |k,v|
            context "#{k} => #{v}" do
              cust_param_precon = <<-END
class { 'musicbot_discord': #{k.to_s} => '#{v}', }
              END
              let(:pre_condition) { cust_param_precon }
              it do
                is_expected.to contain_file(v)
                is_expected.to contain_vcsrepo('musicbot_repo').with_path(v)
              end

            end
          end
        end
      end
    end
  end

end