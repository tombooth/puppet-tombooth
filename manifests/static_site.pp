define tombooth::static_site(
  $server_name,
  $source_root = $::vm_source_root
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

  if $source_root {
    file { "/var/www/${name}/source":
      ensure => link,
      target => "${source_root}/${name}"
    }

    file { "/var/www/${name}/current":
      ensure => link,
      target => "/var/www/${name}/source"
    }
  }

  nginx::resource::vhost { $name:
    server_name => $server_name,
    www_root    => "/var/www/${name}/current",
    access_log  => "/var/www/${name}/logs/access.log",
    error_log   => "/var/www/${name}/logs/error.log",
  }

}
