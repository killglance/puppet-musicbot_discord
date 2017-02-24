class musicbot_discord::repos {
  include ::apt

  create_resources(apt::ppa, $::musicbot_discord::repos, $musicbot_discord::ppa_dep)
}