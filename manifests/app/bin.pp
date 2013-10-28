define tombooth::app::bin(
  $exec,
  $cwd,
) {

  file { "/usr/local/bin/${name}":
    ensure => present,
    content => template('tombooth/bin.erb'),
    mode => '0755',
  }

}
