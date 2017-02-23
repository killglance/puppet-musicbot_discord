class musicbot_discord::params {

  $dep_pkgs = [
    'build-essential',
    'ffmpeg',
    'libopus-dev',
    'libffi-dev',
    'libsodium-dev',
    'unzip',
  ]

  case $::lsbdistcodename {
    'trusty': {
      $dist_deps = [
        'python',
        'python3.5-dev',
        'software-properties-common',
      ]
      $repos = {
        'ppa:fkrull/deadsnakes'   => { },
        'ppa:mc3man/trusty-media' => { },
        'ppa:chris-lea/libsodium' => { },
      }
    }
    'xenial': {
      $dist_deps = [
        'python3-pip',
      ]
      $repos = {
        'ppa:mc3man/xerus-media' => {},
      }
    }
    default: {
      fail("Distribution not supported: ${$::lsbdistcodename}")
    }
  }
}
