class musicbot_discord::install {
  require ::musicbot_discord::repos

  ensure_packages(concat($::musicbot_discord::dep_pkgs, $::musicbot_discord::dist_deps))
}
