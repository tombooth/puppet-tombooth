define tombooth::bin(
  $exec,
) {

  tombooth::deployable { $name:
    root => '/var/bin',
    log_prefix => 'bin-',
  }

  file { "/usr/local/bin/${name}":
    ensure => link,
    target => "${bin_dir}/current/${exec}",
  }

}
