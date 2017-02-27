class musicbot_discord::install {
  require ::musicbot_discord::repos

  ensure_packages(concat($::musicbot_discord::dep_pkgs, $::musicbot_discord::dist_deps))

  user { $::musicbot_discord::user:
    ensure     => 'present',
    comment    => 'Musicbot user, created by Puppet',
    managehome => true,

  }
  file { $::musicbot_discord::install_dir:
    ensure => directory,
    mode   => '0755',
    owner  => $::musicbot_discord::user,
  }

  # Clone down the actual bot repo
  vcsrepo { 'musicbot_repo':
    ensure   => present,
    path     => $::musicbot_discord::install_dir,
    source   => 'https://github.com/Just-Some-Bots/MusicBot.git',
    provider => git,
    revision => 'master',
    user     => $::musicbot_discord::user,
    require  => File[$::musicbot_discord::install_dir],
  }
}
