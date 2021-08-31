# Class to install and configure boundary.
#
# Use this module to install and configure boundary.
#
# @example Declaring the class
#   include ::boundary
#
# @param archive_source Location of boundary binary release.
# @param group Group that owns boundary files.
# @param install_dir Location of boundary binary release.
# @param install_method How to install boundary.
# @param manage_repo Manage the boundary repo.
# @param manage_service Manage the boundary service.
# @param manage_user Manage boundary user and group.
# @param package_name Name of package to install.
# @param package_version Version of boundary to install.
# @param service_name Name of service to manage.
# @param service_provider Init system that is used.
# @param service_ensure The state of the service.
# @param user User that owns boundary files.
class boundary (
  String[1] $group,
  Stdlib::Absolutepath $install_dir,
  Enum['archive','package'] $install_method ,
  Boolean $manage_repo,
  Boolean $manage_service,
  Boolean $manage_user,
  String[1] $package_name,
  String[1] $package_version,
  String[1] $service_name,
  String[1] $service_provider,
  Enum['running','stopped'] $service_ensure,
  String[1] $user,
  Optional[Stdlib::HTTPUrl] $archive_source = undef,
) {
  anchor { 'boundary::begin': }
  -> class{ '::boundary::install': }
  -> class{ '::boundary::config': }
  ~> class{ '::boundary::service': }
  -> anchor { 'boundary::end': }
}
