class tombooth::nodejs(
  $version = 'latest',
) {

  exec { 'apt-get-update-for-node':
    command => '/usr/bin/apt-get update'
  }

  apt::ppa { 'ppa:chris-lea/node.js':
    require => Exec['apt-get-update-for-node']
  }

  package { 'nodejs':
    ensure => $version,
    require => Apt::Ppa['ppa:chris-lea/node.js']
  }

}
