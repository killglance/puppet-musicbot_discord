class musicbot_discord::install {
  require ::musicbot_discord::repos

  $bot_dep_pkgs = [
    'build-essential',
    'unzip',
  ]
  package { $bot_dep_pkgs:
    ensure => present,
  }
}