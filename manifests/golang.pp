class tombooth::golang (
  $source,
  $ensure = present,
) {

  $version_regex = '^http[s]?.+go(.+)\.[linux|darwin|windows|freebsd]+-[amd64|386]+\.tar\.gz$'

  validate_re($source, $version_regex,
    'Please use a valid source url from https://code.google.com/p/go/downloads/list')

  $version = regsubst($source, $version_regex, '\1')
  $install_path = "/usr/local/go${version}"

  archive { $version:
    ensure => $ensure,
    url => $source,
    checksum => false,
    target => $install_path
  }

  if $ensure == 'present' {
    $link_ensure = 'link'
  } else {
    $link_ensure = $present
  }

  file { "/usr/local/bin/go${version}":
    ensure => $link_ensure,
    target => "${install_path}/go/bin/go",
  }

  file { "/usr/local/bin/godoc${version}":
    ensure => $link_ensure,
    target => "${install_path}/go/bin/godoc",
  }

  file { "/usr/local/bin/gofmt${version}":
    ensure => $link_ensure,
    target => "${install_path}/go/bin/gofmt",
  }

  file { "/usr/local/bin/gohome${version}":
    ensure => $link_ensure,
    target => "${install_path}/go/bin/gohome",
  }

}
