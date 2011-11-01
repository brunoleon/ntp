# = Class: ntp
#
# * Setup proper time management
class ntp (
  $server_region = false
) {
  if ! $::ec2_instance_id {
    case $::lsbdistid {
      /(Ubuntu|ubuntu|Debian|debian)/   : { 
        class { 'ntp::openntpd':
          server_region => $server_region
        }
      }
      /(centos|RedHatEnterpriseServer)/ : { include ntp::standard }
    }
  }
  else {
    include ntp::ec2
  }
}

