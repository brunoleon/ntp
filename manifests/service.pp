class ntp::service {
  service { $ntp::variables::svc:
    ensure     => running,
    hasstatus  => $ntp::variables::svc_hasstatus_real,
    hasrestart => $ntp::variables::svc_hasrestart_real,
    pattern    => $ntp::variables::svc_pattern,
  }
}
