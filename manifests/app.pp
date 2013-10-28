define tombooth::app (
  $exec,
  $description = "${name} app",
) {

  tombooth::deployable { $name:
    root => '/var/app',
    log_prefix => 'app-',
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

