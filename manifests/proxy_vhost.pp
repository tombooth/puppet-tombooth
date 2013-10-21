define tombooth::proxy_vhost (
  $server_name,
  $upstream
) {

  if is_array(upstream) {

    nginx::resource::upstream { "${name}-upstream":
      ensure => present,
      members => $upstream,
    }

    $proxy = "http://${name}-upstream"

  } else {

    $proxy = $upstream

  }

  nginx::resource::vhost { $name:
    server_name => $server_name,
    proxy       => $proxy,
  }

}