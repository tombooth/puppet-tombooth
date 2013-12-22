class tombooth::collectd(
  $fqdnlookup   = true,
  $interval     = 10,
  $purge        = undef,
  $purge_config = false,
  $recurse      = undef,
  $threads      = 5,
  $timeout      = 2,
  $typesdb      = [],
  $version      = installed,
) {

  class { '::collectd':
    fqdnlookup   => $fqdnlookup,
    interval     => $interval,
    purge        => $purge,
    purge_config => $purge_config,
    recurse      => $recurse,
    threads      => $threads,
    timeout      => $timeout,
    typesdb      => $typesdb,
    version      => $version,
    require      => Apt::Ppa['ppa:tombooth/ppa'],
  }

}
