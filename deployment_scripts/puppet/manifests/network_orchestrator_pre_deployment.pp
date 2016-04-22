$role = hiera('role')
if $role == 'primary-network-orchestrator-node' or $role == 'network-orchestrator-node' {
    # we are installing mitaka on these nodes. the packaging for the neutron plguins was
    # changed and the upstart service names have changed. this ensures compat. with the
    # puppet modules that assume liberty packages
    file { 'neutron-openvswitch-agent-upstart':
        ensure  => present,
        path    => '/etc/init/neutron-plugin-openvswitch-agent.conf',
        source  => 'puppet:///modules/astara/neutron-plugin-openvswitch-agent.conf',
        replace => true,
        owner   => '0',
        group   => '0',
        mode    => '0644',
    }

}
