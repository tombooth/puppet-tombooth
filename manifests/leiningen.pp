class tombooth::leiningen(
  $url,
) {

  include tombooth::java

  exec { 'install-leiningen':
    path => ['/bin', '/usr/bin', '/usr/local/bin'],
    cwd => '/usr/local/bin',
    command => "curl ${url} > lein && chmod 755 lein",
    creates => ['/usr/local/bin/lein'],
    require => Package['curl'],
  }

}
