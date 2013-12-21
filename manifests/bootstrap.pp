class tombooth::bootstrap(
  $sudo_group = 'allaccess',
) {

  stage { 'bootstrap':
    before => Stage['main'],
  }

  class { 'tombooth::apt_update':
    stage => 'bootstrap',
  }

  group { $sudo_group: ensure => present }

  file { "/etc/sudoers.d/${sudo_group}":
    ensure  => present,
    mode    => '0440',
    content => "%${sudo_group} ALL=(ALL) NOPASSWD: ALL"
  }

  # Set up accounts
  $accounts = hiera_hash( 'accounts', {} )
  if !empty($accounts) {
    create_resources( 'account', $accounts )
  }

  $system_packages = hiera_array( 'system_packages', [] )
  if !empty($system_packages) {
    package { $system_packages:
      ensure => installed,
    }
  }

  # Firewall rules
  $ufw_rules = hiera_hash( 'ufw_rules', {} )
  if !empty($ufw_rules) {
    create_resources( 'ufw::allow', $ufw_rules )
  }

  $apps = hiera_hash( 'apps', {} )
  if !empty($apps) {
    create_resources( 'tombooth::app', $apps )
  }

  $static_sites = hiera_hash( 'static_sites', {} )
  if !empty($static_sites) {
    create_resources( 'tombooth::static_site', $static_sites )
  }

  $proxy_vhosts = hiera_hash( 'proxy_vhosts', {} )
  if !empty($proxy_vhosts) {
    create_resources( 'tombooth::proxy_vhost', $proxy_vhosts )
  }

}