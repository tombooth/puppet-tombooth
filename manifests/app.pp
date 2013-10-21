define tombooth::app (
  $exec,
  $description = "${name} app",
  $source_root = $::vm_source_root,
) {

  if !defined(File['/var/app']) {
    file { '/var/app':
      ensure => directory,
    }
  }

  file { "/var/app/${name}":
    ensure  => directory,
  }

  file { "/var/app/${name}/logs":
    ensure => directory,
  }

  file { "/var/log/app-${name}":
    ensure => link,
    target => "/var/app/${name}/logs",
  }

  if $source_root {
    file { "/var/app/${name}/source":
      ensure => link,
      target => "${source_root}/${name}"
    }

    file { "/var/app/${name}/current":
      ensure => link,
      target => "/var/app/${name}/source"
    }
  }

  upstart::job { $name:
    description => $description,
    respawn => true,
    respawn_limit => '5 10',
    chdir => "/var/app/${name}/current",
    exec => $exec
  }

  file { "/var/app/${name}/logs/upstart.log":
    ensure => link,
    target => "/var/log/upstart/${name}.log",
  }

}

