class astara::repo {
   include apt
   $role = hiera('role')
   if hiera('fuel_version') == '8.0' {
      if $role == 'controller' or $role == 'primary-controller' {
              notice('MODULAR: astara - Installing controller version for Liberty')
              apt::ppa { 'ppa:astara-drivers/astara-liberty': }
              exec {
                'apt-get update':
                path => '/usr/bin/',
                require => Apt::Ppa['ppa:astara-drivers/astara-liberty'] }
      } else {
              notice('MODULAR: astara - Installing Mitaka version for Liberty')
              package { 'ubuntu-cloud-keyring': ensure => 'present' }
              apt::ppa { 'ppa:astara-drivers/astara-mitaka': }
              apt::source { 'ubuntu-cloud':
                  location          =>  'http://ubuntu-cloud.archive.canonical.com/ubuntu',
                  repos             =>  'main',
                  release           =>  'trusty-updates/mitaka',
                  include           => { 'src' => false },
                  require           => Package['ubuntu-cloud-keyring'],
              }
              exec {
                'apt-get update':
                path => '/usr/bin/',
                require => [Apt::Ppa['ppa:astara-drivers/astara-mitaka'], Apt::Source['ubuntu-cloud']] }

       }
   } else {
      fail('Currently Astara deployment supported only with Fuel 8.0/liberty')
   }
}
