class musicbot_discord::repos {
  include ::apt

  create_resources(apt::ppa, $::musicbot_discord::repos, { require => Package['software-properties-common'] })
}