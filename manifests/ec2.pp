# = Class: ntp::ec2
#
# This class setups timezone properly for an  EC2 instance
class ntp::ec2 {
  file { '/etc/localtime':
    ensure  => link,
    target  => $::ec2_placement_availability_zone ? {
      /us-east-1/       => '/usr/share/zoneinfo/EST5EDT',
      /us-west-1/       => '/usr/share/zoneinfo/PST8PDT',
      /eu-west-1/       => '/usr/share/zoneinfo/Europe/Dublin',
      /ap-southeast-1/  => '/usr/share/zoneinfo/Singapore',
    },
  }

  file { '/etc/timezone':
    ensure  => file,
    mode    => '0644',
    content => $::ec2_placement_availability_zone ? {
      /us-east-1/       => 'EST5EDT',
      /us-west-1/       => 'PST8PDT',
      /eu-west-1/       => 'Dublin',
      /ap-southeast-1/  => 'Singapore',
    },
  }
}

