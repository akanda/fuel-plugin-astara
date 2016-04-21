notice('MODULAR: networks.pp')

$astara_settings = hiera('fuel-plugin-astara')

$mgt_net_name = $astara_settings['astara_mgmt_name']
$mgt_prefix = $astara_settings['astara_mgmt_ipv6_prefix']

class astara::networks {
	if hiera('role') == 'primary-network-orchestrator-node' {
		exec { 'create networks':
			path => '/bin:/usr/bin',
			command => '/bin/bash ./scripts/create_neutron_networks.sh ${mgt_net_name} ${mgt_prefix}',
			logoutput => true,
		}
	} else {
		exec { 'set networks':
			path => '/bin:/usr/bin',
			command => '/bin/bash ./scripts/set_neutron_networks.sh ${mgt_net_name} ${mgt_prefix}',
			logoutput => true,
		}

	}
	astara_config {
		'router/instance_networks': value => $networks_id;
		'loadbalancer/instance_networks': value => $networks_id;
	}
}
