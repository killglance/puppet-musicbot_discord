class musicbot_discord::config {
  $options_file = "${::musicbot_discord::install_dir}/config/example_options.ini"
  $real_options_file = "${::musicbot_discord::install_dir}/config/options.ini"

  $default_ini_params = {
    ensure => present,
    path   => $::musicbot_discord::config::options_file,

  }
  $option_settings = {
    'bot_token'           => {
      section => 'Credentials',
      setting => 'Token',
      value   => $::musicbot_discord::token,
    },
    'prefix'              => {
      section => 'Chat',
      setting => 'CommandPrefix',
      value   => $::musicbot_discord::command_prefix,
    },
    'auto_summons'        => {
      section => 'MusicBot',
      setting => 'AutoSummon',
      value   => $::musicbot_discord::auto_summon,
    },
    'auto_pause'          => {
      section => 'MusicBot',
      setting => 'AutoPause',
      value   => $::musicbot_discord::auto_pause,
    },
    'auto_playlists'      => {
      section => 'MusicBot',
      setting => 'UseAutoPlaylist',
      value   => $::musicbot_discord::auto_playlist,
    },
    'debug'               => {
      section => 'MusicBot',
      setting => 'DebugMode',
      value   => $::musicbot_discord::debug,
    },
    'default_volume'      => {
      section => 'MusicBot',
      setting => 'DefaultVolume',
      value   => $::musicbot_discord::default_volume,
    },
    'delete_invoke'       => {
      section => 'MusicBot',
      setting => 'DeleteInvoking',
      value   => $::musicbot_discord::delete_invoke,
    },
    'delete_messages'     => {
      section => 'MusicBot',
      setting => 'DeleteMessages',
      value   => $::musicbot_discord::delete_msgs,
    },
    'nowplaying_mentions' => {
      section => 'MusicBot',
      setting => 'NowPlayingMentions',
      value   => $::musicbot_discord::np_mentions,
    },
    'owner'               => {
      section => 'Permissions',
      setting => 'OwnerID',
      value   => $::musicbot_discord::owner_id,
    },
    'skip'                => {
      section => 'MusicBot',
      setting => 'SkipsRequired',
      value   => $::musicbot_discord::required_skip,
    },
    'save_videos'         => {
      section => 'MusicBot',
      setting => 'SaveVideos',
      value   => $::musicbot_discord::save_vids,
    },
    'skip_ratio'          => {
      section => 'MusicBot',
      setting => 'SkipRatio',
      value   => $::musicbot_discord::skip_ratio,
    },
    'whitelist'           => {
      section => 'MusicBot',
      setting => 'WhiteListCheck',
      value   => $::musicbot_discord::whitelist_check,
    }
  }
  create_resources(ini_setting, $option_settings, $default_ini_params)

  # In order to not maintain a complete ERB template, adjust the example_options.ini and then copy into place
  file { 'real_options_file':
    ensure => file,
    path   => $real_options_file,
    mode   => '0644',
    owner  => $::musicbot_discord::user,
    group  => $::musicbot_discord::user,
    source => $options_file,
  }

  if $::musicbot_discord::autojoin_chan {
    ini_setting { 'autojoin':
      ensure  => present,
      path    => $::musicbot_discord::config::options_file,
      section => 'Chat',
      setting => 'AutojoinChannels',
      value   => $::musicbot_discord::autojoin_chan,
    }
  }
  if $::musicbot_discord::bind_to_chan {
    ini_setting { 'bindtochannel':
      ensure  => present,
      path    => $::musicbot_discord::config::options_file,
      section => 'Chat',
      setting => 'BindToChannels',
      value   => $::musicbot_discord::bind_to_chan,
    }
  }
}