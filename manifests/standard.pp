# = Class: ntp::standard
#
# * Installs ntp daemon
class ntp::standard {
  package { 'ntp':
    ensure => present
  }

  service { 'ntpd':
    ensure      => running,
    enable      => true,
    hasstatus   => true,
    require     => Package['ntp'],
  }
}

