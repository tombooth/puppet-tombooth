define tombooth::deployable(
  $root,
  $log_prefix = '',
  $source_root = $::vm_source_root,
) {

  if !defined(File[$root]) {
    file { $root:
      ensure => directory,
    }
  }

  $deployable_dir = "${root}/${name}"

  file { $deployable_dir
    ensure  => directory,
  }

  file { "${deployable_dir}/logs":
    ensure => directory,
  }

  file { "/var/log/${log_prefix}${name}":
    ensure => link,
    target => "${deployable_dir}/logs",
  }

  if $source_root {
    file { "${deployable_dir}/source":
      ensure => link,
      target => "${source_root}/${name}"
    }

    file { "${deployable_dir}/current":
      ensure => link,
      target => "${bin_dir}/source"
    }
  }

}
