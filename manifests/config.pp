class ntp::config {
  file { $ntp::variables::default_conf_path:
    content => template( "${module_name}/header.erb", $ntp::variables::default_conf_src ),
    ensure  => file,
  }
  file { $ntp::variables::conf_path:
    content => template( "${module_name}/header.erb", $ntp::variables::conf_src ),
    ensure  => file,
  }
}
