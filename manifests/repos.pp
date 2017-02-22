class musicbot_discord::repos {
  include ::apt

  # PPA installation requires this package on a minimal trusty install
  package { 'software-properties-common': ensure => present, }

  $repos = {
    'ppa:fkrull/deadsnakes' => {},
    'ppa:mc3man/trusty-media' => {},
    'ppa:chris-lea/libsodium' => {},
  }
  create_resources( apt::ppa, $repos, { require => Package['software-properties-common'] } )
}