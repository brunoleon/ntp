# = Class: ntp
#
# * Setup proper time management
class ntp (
  $server_region  = '',
  $ntpdate_server = '91.189.94.4',
) {

  validate_string( $server_region )

  if ! $::ec2_instance_id {
    case $::osfamily {
      /(?i-mx:debian)/: {
        class { 'ntp::openntpd':
          server_region => $ntp::server_region
        }
        if ! is_ip_address( $ntpdate_server ) {
          fail( 'You should provide an IP and not a hostname here. NTPDATE fails DNS resolution at boot time.')
        }
        file { '/etc/default/ntpdate':
          ensure  => file,
          content => template( 'ntp/default_ntpdate.erb' ),
        }
      }
      /(?i-mx:redhat)/: {
        include ntp::standard
      }
      default: {
        fail( 'Unsupported operating system' )
      }
    }
  }
  else {
    include ntp::ec2
  }
}

