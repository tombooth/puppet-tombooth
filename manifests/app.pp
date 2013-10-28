define tombooth::app (
  $services = {},
  $bin = {},
  $root = '/var/app',
  $log_prefix = 'app-',
) {

  validate_hash($services)
  validate_hash($bin)

  tombooth::deployable { $name:
    root => $root,
    log_prefix => $log_prefix,
  }

  $deployed_dir = "${root}/${name}/current"
  $log_dir = "${root}/${name}/logs"

  if !empty($services) {

    $service_defaults = {
      cwd => $deployed_dir,
      log_dir => $log_dir,
    }

    create_resources( 'tombooth::app::service', $services, $service_defaults )

  }

  if !empty($bin) {

    $bin_defaults = {
      cwd => $deployed_dir,
    }

    create_resources( 'tombooth::app::bin', $bin, $bin_defaults )

  }

  file { "${root}/${name}/descriptor.json":
    ensure => present,
    content => template('tombooth/descriptor.json.erb')
  }

}

