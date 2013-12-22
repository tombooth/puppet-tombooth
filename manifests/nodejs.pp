class tombooth::nodejs(
) {

  package { 'nodejs':
    ensure  => present,
    require => Apt::Ppa['ppa:tombooth/ppa']
  }

}
