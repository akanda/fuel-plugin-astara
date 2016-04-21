
class astara::install {
    class { 'astara::repo': }

    package { 'astara-orchestrator':
	ensure => 'present',
	require => Class['astara::repo'],
	tag => ['openstack', 'astara-orchestrator-package'],
    }
}
