define tombooth::app::service (
  $exec,
  $cwd,
  $log_dir,
  $respawn = true,
  $respawn_limit = '5 10',
  $description = "${name} app",
) {

  upstart::job { $name:
    description => $description,
    respawn => $respawn,
    respawn_limit => $respawn_limit,
    chdir => $cwd,
    exec => $exec
  }

  file { "${log_dir}/${name}-upstart.log":
    ensure => link,
    target => "/var/log/upstart/${name}.log",
  }

}
