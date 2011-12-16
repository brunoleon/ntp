# = Class: ntp::openntpd
#
# * Installs ntp daemon, optionally using the closest server as specified
class ntp::openntpd (
  $server_region = false
) {
  package { 'openntpd' :
    ensure => present,
  }

  file { '/etc/default/openntpd':
    source  => 'puppet:///modules/ntp/default_openntpd',
    ensure  => file,
  }

  file { '/etc/openntpd/ntpd.conf':
    content => template('ntp/openntpd.conf.erb'),
    ensure  => file,
    require => Package[ 'openntpd' ],
    notify  => Service[ 'openntpd' ],
  }

  if $::lsbdistcodename in [ 'hardy', 'lucid' ] {
    $hasstatus = false
    $pattern   = 'ntpd'
  }
  else {
    $hasstatus = true
    $pattern   = undef
  }

  service { 'openntpd':
    ensure      => running,
    enable      => true,
    hasstatus   => $hasstatus,
    require     => Package[openntpd],
    pattern     => $pattern,
  }
}

