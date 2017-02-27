class musicbot_discord::params {

  $user = 'musicbot'
  $dep_pkgs = [
    'build-essential',
    'ffmpeg',
    'git',
    'libopus-dev',
    'libffi-dev',
    'libsodium-dev',
    'unzip',
  ]

  $install_dir = '/opt/musicbot'

  case $::lsbdistcodename {
    'trusty': {
      $dist_deps = [
        'python',
        'python3.5-dev',
      ]
      $repos = {
        'ppa:fkrull/deadsnakes'   => { },
        'ppa:mc3man/trusty-media' => { },
        'ppa:chris-lea/libsodium' => { },
      }
      $ppa_dep_pkg = 'software-properties-common'
      $ppa_dep = { require => Package['software-properties-common'], }
    }
    'xenial': {
      $dist_deps = [
        'python3-pip',
      ]
      $repos = {
        'ppa:mc3man/xerus-media' => { },
      }
      $ppa_dep = { }
    }
    default: {
      fail("Distribution not supported: ${$::lsbdistcodename}")
    }
  }

  $autojoin_chan = undef
  $auto_pause = 'yes'
  $auto_playlist = 'yes'
  $auto_summon = 'yes'
  $bind_to_chan = undef
  $command_prefix = '!'
  $debug = 'no'
  $default_volume = '0.15'
  $delete_invoke = 'no'
  $delete_msgs = 'yes'
  $np_mentions = 'no'
  $owner_id = '000000000000000000'
  $required_skip = '4'
  $save_vids = 'yes'
  $skip_ratio = '0.5'
  $token = 'bot_token'
  $whitelist_check = 'no'
}
