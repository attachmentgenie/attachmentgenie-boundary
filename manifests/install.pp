# Class to install example.
#
# @api private
class example::install {
  if $::example::manage_user {
    user { 'example':
      ensure => present,
      home   => $::example::install_dir,
      name   => $::example::user,
    }
    group { 'example':
      ensure => present,
      name   => $::example::group
    }
  }
  case $::example::install_method {
    'package': {
      if $::example::manage_repo {
        class { 'example::repo': }
      }
      package { 'example':
        ensure => $::example::package_version,
        name   => $::example::package_name,
      }
    }
    'archive': {
      file { 'example install dir':
        ensure => directory,
        group  => $::example::group,
        owner  => $::example::user,
        path   => $::example::install_dir,
      }
      if $::example::manage_user {
        File[$::example::install_dir] {
          require => [Group['example'],User['example']],
        }
      }

      archive { 'example archive':
        cleanup      => true,
        creates      => "${::example::install_dir}/example",
        extract      => true,
        extract_path => $::example::install_dir,
        group        => $::example::group,
        path         => '/tmp/example.tar.gz',
        source       => $::example::archive_source,
        user         => $::example::user,
        require      => File['example install dir']
      }

    }
    default: {
      fail("Installation method ${::example::install_method} not supported")
    }
  }
}
