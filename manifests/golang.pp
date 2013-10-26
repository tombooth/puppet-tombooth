class tombooth::golang (
  $source,
  $ensure = present,
) {

  $source_regex = '^http[s]?.+go.+\.[linux|darwin|windows|freebsd]+-[amd64|386]+\.tar\.gz$'

  validate_re($source, $source_regex,
    'Please use a valid source url from https://code.google.com/p/go/downloads/list')

  $install_path = "/usr/local"

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

  file { "/usr/local/bin/go":
    ensure => $link_ensure,
    target => "${install_path}/go/bin/go",
  }

  file { "/usr/local/bin/godoc":
    ensure => $link_ensure,
    target => "${install_path}/go/bin/godoc",
  }

  file { "/usr/local/bin/gofmt":
    ensure => $link_ensure,
    target => "${install_path}/go/bin/gofmt",
  }

  file { "/usr/local/bin/gohome":
    ensure => $link_ensure,
    target => "${install_path}/go/bin/gohome",
  }

}
