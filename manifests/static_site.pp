define tombooth::static_site(
  $server_name
) {

  if !defined(File['/var/www']) {
    file { '/var/www':
      ensure => directory
    }
  }

  file { "/var/www/${name}":
    ensure  => directory,
  }

  file { "/var/www/${name}/logs":
    ensure => directory,
  }

  file { "/var/log/static-${name}":
    ensure => link,
    target => "/var/www/${name}/logs",
  }

  nginx::resource::vhost { $name:
    server_name => $server_name,
    www_root    => "/var/www/${name}/current",
    access_log  => "/var/www/${name}/logs/access.log",
    error_log   => "/var/www/${name}/logs/error.log",
  }

}
