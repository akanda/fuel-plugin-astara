notice('MODULAR: flavor.pp')

class astara::flavor (
	$ram = '512',
	$disk = '3',
	$vcpus = '1',
	$flavor_name = 'm1.astara',		
	$flavor_id = '511',
) {
	if hiera('role') == 'primary-network-orchestrator-node' {
		exec { 'create':
			path => '/bin:/usr/bin',
			command => '/bin/bash ./scripts/create_nova_flavor.sh ${ram} ${disk} ${vcpus} ${flavor_name} ${id}',
			logoutput => true,
		}
	}
	astara_config {
		'router/instance_flavor': value => $flavor_id;
		'loadbalancer/instance_flavor': value => $flavor_id;
	}
}
