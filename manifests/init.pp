# Class to install and configure example.
#
# Use this module to install and configure example.
#
# @example Declaring the class
#   include ::example
#
# @param archive_source Location of example binary release.
# @param group Group that owns example files.
# @param install_dir Location of example binary release.
# @param install_method How to install example.
# @param manage_repo Manage the example repo.
# @param manage_service Manage the example service.
# @param manage_user Manage example user and group.
# @param package_name Name of package to install.
# @param package_version Version of example to install.
# @param service_name Name of service to manage.
# @param service_provider Init system that is used.
# @param service_ensure The state of the service.
# @param user User that owns example files.
class example (
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
  anchor { 'example::begin': }
  -> class{ '::example::install': }
  -> class{ '::example::config': }
  ~> class{ '::example::service': }
  -> anchor { 'example::end': }
}
