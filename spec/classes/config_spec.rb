require 'spec_helper'

describe 'musicbot_discord::config' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) {facts}
      context 'with default parameters' do
        precon = <<-END
class { 'musicbot_discord': }
        END
        let(:pre_condition) {precon}

        # ini_params will return a hash to use for testing parameters. It should look as follows:
        # ini_params.call('section1','setting2','value3')
        # { :section => 'section1', :setting => 'setting2', :value => 'value3' }
        def ini_params(section, setting, value)
          {
              :ensure => 'present',
              :path => '/opt/musicbot/config/example_options.ini',
              :section => section,
              :setting => setting,
              :value => value
          }
        end

        it {is_expected.to contain_ini_setting('bot_token').with(ini_params('Credentials', 'Token', 'bot_token'))}

        it {is_expected.to contain_ini_setting('prefix').with(ini_params('Chat', 'CommandPrefix', '!'))}

        it {is_expected.to contain_ini_setting('auto_summons').with(ini_params('MusicBot', 'AutoSummon', 'yes'))}

        it {is_expected.to contain_ini_setting('auto_pause').with(ini_params('MusicBot', 'AutoPause', 'yes'))}

        it {is_expected.to contain_ini_setting('auto_playlists').with(ini_params('MusicBot', 'UseAutoPlaylist', 'yes'))}

        it {is_expected.to contain_ini_setting('debug').with(ini_params('MusicBot', 'DebugMode', 'no'))}

        it {is_expected.to contain_ini_setting('default_volume').with(ini_params('MusicBot', 'DefaultVolume', '0.15'))}

        it {is_expected.to contain_ini_setting('delete_invoke').with(ini_params('MusicBot', 'DeleteInvoking', 'no'))}

        it {is_expected.to contain_ini_setting('delete_messages').with(ini_params('MusicBot', 'DeleteMessages', 'yes'))}

        it {is_expected.to contain_ini_setting('nowplaying_mentions').with(ini_params('MusicBot', 'NowPlayingMentions', 'no'))}

        it {is_expected.to contain_ini_setting('owner').with(ini_params('Permissions', 'OwnerID', '000000000000000000'))}

        it {is_expected.to contain_ini_setting('whitelist').with(ini_params('MusicBot', 'WhiteListCheck', 'no'))}

        it {is_expected.to contain_ini_setting('skip').with(ini_params('MusicBot', 'SkipsRequired', '4'))}

        it {is_expected.to contain_ini_setting('save_videos').with(ini_params('MusicBot', 'SaveVideos', 'yes'))}

        it {is_expected.to contain_ini_setting('skip_ratio').with(ini_params('MusicBot', 'SkipRatio', '0.5'))}

        it {is_expected.not_to contain_ini_setting('autojoin')}
        it {is_expected.not_to contain_ini_setting('bindtochannel')}

        real_opt_file_params = {
            :ensure => 'file',
            :path => '/opt/musicbot/config/options.ini',
            :mode => '0644',
            :owner => 'musicbot',
            :group => 'musicbot',
            :source => '/opt/musicbot/config/example_options.ini',
        }
        it {is_expected.to contain_file('real_options_file').with(real_opt_file_params)}

        it {is_expected.not_to contain_ini_setting('autojoin')}
        it {is_expected.not_to contain_ini_setting('bindtochannel')}
        # autojoin_params = {
        #     :section => 'Chat',
        #     :setting => 'AutojoinChannels',
        #     :value => nil,
        # }
        # it { is_expected.to contain_ini_setting('autojoin').with(autojoin_params.merge(def_options_params)) }
      end
      {
          autojoin_chan: {
              resource: 'autojoin',
              setting: 'AutojoinChannels',
              value: '00000 11111 2222'
          },
          bind_to_chan: {
              resource: 'bindtochannel',
              setting: 'BindToChannels',
              value: '33333 4444 555'
          },
      }.each do |param, expected_values|
        context "with #{param} => #{expected_values[:value]}" do
          precon = <<-MANIFEST
class { 'musicbot_discord':
  #{param} => '#{expected_values[:value]}',
}
          MANIFEST
          let(:pre_condition) {precon}
          let(:facts) {facts}
          ini_params = {
              ensure: 'present',
              path: '/opt/musicbot/config/example_options.ini',
              section: 'Chat',
              setting: expected_values[:setting],
              value: expected_values[:value]
          }
          it {is_expected.to contain_ini_setting(expected_values[:resource]).with(ini_params) }
        end
      end
    end
  end
end
