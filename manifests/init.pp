# = Class: ntp
#
# * Setup proper time management
class ntp (
  $server_region = false
) {
  if ! $::ec2_instance_id {
    case $::osfamily {
      /(?i-mx:debian)/: {
        class { 'ntp::openntpd':
          server_region => $ntp::server_region
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

