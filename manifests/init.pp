# Class: snapd
# ===========================
#
# This module installs and manages the snapd package/service for using snap
# packages on your system.
#
# Examples
# --------
#
# @example
#    class { 'snapd': }
#
# Authors
# -------
#
# Danny Roberts <danny@thefallenphoenix.net>
#
# Copyright
# ---------
#
# Copyright 2017 Danny Roberts
#
class snapd (
  Array[String[1]]           $packages       = ['snapd'],
  String[1]                  $package_ensure = 'installed',
  String[1]                  $service_name   = $snapd::params::service_name,
  Enum['stopped', 'running'] $service_ensure = 'running',
  Boolean                    $service_enable  = true,
  Boolean                    $symlink_enable = $facts['os']['family'] == 'RedHat',
) inherits snapd::params {
  package { $packages:
    ensure  => $package_ensure,
  }

  if $symlink_enable {
    file { '/snap':
      ensure  => link,
      target  => '/var/lib/snapd/snap',
      require => Package[$packages],
    }
  }

  service { $service_name:
    ensure    => $service_ensure,
    enable    => $service_enable,
    subscribe => Package[$packages],
  }
}
