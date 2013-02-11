class ntp::install {
  package { $ntp::variables::pkg:
    ensure  => present,
  }
}
