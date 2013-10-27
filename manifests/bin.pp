define tombooth::bin(
  $exec,
  $source_root = $::vm_source_root,
) {

  if !defined(File['/var/bin']) {
    file { '/var/bin':
      ensure => directory,
    }
  }

  $bin_dir = "/var/bin/${name}"

  file { $bin_dir:
    ensure  => directory,
  }

  file { "${bin_dir}/logs":
    ensure => directory,
  }

  file { "/var/log/bin-${name}":
    ensure => link,
    target => "${bin_dir}/logs",
  }

  if $source_root {
    file { "${bin_dir}/source":
      ensure => link,
      target => "${source_root}/${name}"
    }

    file { "${bin_dir}/current":
      ensure => link,
      target => "${bin_dir}/source"
    }
  }

  file { "/usr/local/bin/${name}":
    ensure => link,
    target => "${bin_dir}/current/${exec}",
  }

}
