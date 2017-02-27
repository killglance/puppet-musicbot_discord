class musicbot_discord::repos {
  include ::apt

  # Define package here to avoid circular dependencies
  if $::lsbdistcodename == 'trusty' {
    package { $musicbot_discord::ppa_dep_pkg: ensure => present, }
  }

  create_resources(apt::ppa, $::musicbot_discord::repos, $musicbot_discord::ppa_dep)
}