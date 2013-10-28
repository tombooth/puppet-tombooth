define tombooth::static_site(
  $server_name,
) {

  tombooth::deployable { $name:
    root => '/var/www',
    log_prefix => 'static-',
  }

  nginx::resource::vhost { $name:
    server_name => $server_name,
    www_root    => "/var/www/${name}/current",
    access_log  => "/var/www/${name}/logs/access.log",
    error_log   => "/var/www/${name}/logs/error.log",
  }

}
