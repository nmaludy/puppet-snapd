# params
class snapd::params {
  $service_name = $facts['os']['family'] ? {
    'Archlinux' => 'snapd.socket',
    'Debian'    => 'snapd',
    'RedHat'    => 'snapd.socket',
    default     => 'snapd'
  }
}
