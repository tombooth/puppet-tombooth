class tombooth::java {

  exec {
    'set-licence-selected':
      command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections';
    'set-licence-seen':
      command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections';
  }

  exec { 'apt-get-update-for-java':
    command => '/usr/bin/apt-get update'
  }

  apt::ppa { 'ppa:webupd8team/java':
    require => Exec['apt-get-update-for-java']
  }

  package { 'oracle-java7-installer':
    ensure  => present,
    require => [
      Apt::Ppa['ppa:webupd8team/java'],
      Exec['set-licence-selected'],
      Exec['set-licence-seen']
    ],
  }

}
