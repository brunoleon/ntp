# = Class: ntp
#
# * Setup proper time management
class ntp (
  $server_region    = '',
  $force_on_virtual = false,
  $defaults_options = $ntp::variables::default_options,
) inherits ntp::variables {

  validate_bool( $force_on_virtual )
  validate_string( $server_region, $defaults_options )

  if ( $::is_virtual == 'true' ) and ( ! $force_on_virtual ) {
    # Using NTP on a VM is usually not a good idea
    fail( 'You need to set $force_on_virtual = true to apply this module to a VM' )
  }

  Class[ "${module_name}::install" ] ->
  Class[ "${module_name}::config" ] ~>
  Class[ "${module_name}::service" ]

  include "${module_name}::install"
  include "${module_name}::config"
  include "${module_name}::service"
}
