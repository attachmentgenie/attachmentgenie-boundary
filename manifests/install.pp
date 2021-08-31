# Class to install boundary.
#
# @api private
class boundary::install {
  if $::boundary::manage_user {
    user { 'boundary':
      ensure => present,
      home   => $::boundary::install_dir,
      name   => $::boundary::user,
    }
    group { 'boundary':
      ensure => present,
      name   => $::boundary::group
    }
  }
  case $::boundary::install_method {
    'package': {
      if $::boundary::manage_repo {
        class { 'boundary::repo': }
      }
      package { 'boundary':
        ensure => $::boundary::package_version,
        name   => $::boundary::package_name,
      }
    }
    'archive': {
      file { 'boundary install dir':
        ensure => directory,
        group  => $::boundary::group,
        owner  => $::boundary::user,
        path   => $::boundary::install_dir,
      }
      if $::boundary::manage_user {
        File[$::boundary::install_dir] {
          require => [Group['boundary'],User['boundary']],
        }
      }

      archive { 'boundary archive':
        cleanup      => true,
        creates      => "${::boundary::install_dir}/boundary",
        extract      => true,
        extract_path => $::boundary::install_dir,
        group        => $::boundary::group,
        path         => '/tmp/boundary.tar.gz',
        source       => $::boundary::archive_source,
        user         => $::boundary::user,
        require      => File['boundary install dir']
      }

    }
    default: {
      fail("Installation method ${::boundary::install_method} not supported")
    }
  }
}
