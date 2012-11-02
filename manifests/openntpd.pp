# = Class: ntp::openntpd
#
# * Installs ntp daemon, optionally using the closest server as specified
class ntp::openntpd (
  $server_region,
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

  if $::productname == 'KVM' {
    $service_ensure = 'stopped'
    $service_enable = false
  } else {
    $service_ensure = 'running'
    $service_enable = true
  }

  service { 'openntpd':
    ensure      => $service_ensure,
    enable      => $service_enable,
    hasstatus   => $hasstatus,
    pattern     => $pattern,
    require     => Package[ 'openntpd' ],
  }
}
