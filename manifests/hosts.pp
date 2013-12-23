class tombooth::hosts(
) {

  $hosts = hiera_hash( 'hosts', {} )
  if !empty($hosts) {
    create_resources( 'host', $hosts )
  }

}
