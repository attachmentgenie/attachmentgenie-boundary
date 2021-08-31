# Class to manage the example service.
#
# @api private
class example::service {
  if $::example::manage_service {
    case $::example::service_provider {
      'systemd': {
        ::systemd::unit_file { "${::example::service_name}.service":
          content => template('example/example.service.erb'),
          before  => Service['example'],
        }
      }
      default: {
        fail("Service provider ${::example::service_provider} not supported")
      }
    }

    case $::example::install_method {
      'archive': {}
      'package': {
        Service['example'] {
          subscribe => Package['example'],
        }
      }
      default: {
        fail("Installation method ${::example::install_method} not supported")
      }
    }

    service { 'example':
      ensure   => $::example::service_ensure,
      enable   => true,
      name     => $::example::service_name,
      provider => $::example::service_provider,
    }
  }
}
