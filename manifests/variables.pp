class ntp::variables {
  case $::osfamily {
    'Debian': {
      $default_base = '/etc/default'
      case $::operatingsystem {
        'Debian': {
          $pkg               = 'ntp'
          $svc               = $pkg
          $default_conf_path = "${default_base}/$pkg"
          $default_conf_src  = "${module_name}/default_debian.erb"
          $default_options   = '-g'
          $conf_path         = '/etc/ntp.conf'
          $conf_src          = "${module_name}/ntp.conf.erb"
        }
        'Ubuntu': {
          $pkg               = 'openntpd'
          $svc               = $pkg
          $default_conf_path = "$default_base/$pkg"
          $default_conf_src  = "${module_name}/default_ubuntu.erb"
          $default_options   = '-s'
          $conf_path         = '/etc/openntpd/ntpd.conf'
          $conf_src          = "${module_name}/openntpd.conf.erb"
          if $::lsbdistcodename in [ 'hardy', 'lucid' ] {
            $svc_hasstatus = false
            $svc_pattern   = 'ntpd'
          }
        }
        default : {
          fail( 'Unsupported operating system' )
        }
      }
    }
    'RedHat': {
      $pkg               = 'ntp'
      $svc               = 'ntpd'
      $default_conf_path = "/etc/sysconfig/$pkg"
      $default_conf_src  = "${module_name}/default_redhat.erb"
      $default_options   = '-u ntp:ntp -p /var/run/ntpd.pid -g'
      $conf_path         = '/etc/ntp.conf'
      $conf_src          = "${module_name}/ntp.conf.erb"
    }
    default: {
      fail( 'Unsupported operating system' )
    }
  }
  $svc_hasstatus_real = $svc_hasstatus ? {
    undef   => true,
    default => $svc_hasstatus,
  }
  $svc_hasrestart_real = $svc_hasrestart ? {
    undef   => true,
    default => $svc_hasrestart,
  }
}
