# Class to manage the boundary service.
#
# @api private
class boundary::service {
  if $::boundary::manage_service {
    case $::boundary::service_provider {
      'systemd': {
        ::systemd::unit_file { "${::boundary::service_name}.service":
          content => template('boundary/boundary.service.erb'),
          before  => Service['boundary'],
        }
      }
      default: {
        fail("Service provider ${::boundary::service_provider} not supported")
      }
    }

    case $::boundary::install_method {
      'archive': {}
      'package': {
        Service['boundary'] {
          subscribe => Package['boundary'],
        }
      }
      default: {
        fail("Installation method ${::boundary::install_method} not supported")
      }
    }

    service { 'boundary':
      ensure   => $::boundary::service_ensure,
      enable   => true,
      name     => $::boundary::service_name,
      provider => $::boundary::service_provider,
    }
  }
}
