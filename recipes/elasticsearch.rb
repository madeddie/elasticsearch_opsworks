#
# Cookbook Name:: elasticsearch_opsworks
# Recipe:: elasticsearch
#

include_recipe 'apt'
include_recipe 'java::default'

elasticsearch_user 'elasticsearch'
elasticsearch_install 'elasticsearch'
elasticsearch_configure 'elasticsearch' do
  path_data package: '/mnt/elasticsearch-data'
  configuration(
    'bootstrap.mlockall'                      => true,
    'action.disable_delete_all_indices'       => true,
    'network.host'                            => '0.0.0.0',
    'routing.allocation.awareness.attributes' => 'aws_availability_zone',
    'discovery.zen.ping.multicast.enabled'    => false,
    'discovery.type'                          => 'ec2',
    'plugin.mandatory'                        => 'cloud-aws',
    'cloud.node.auto_attributes'              => true,
    'cloud.aws.region'                        => node['ec2']['placement_availability_zone'].chop,
    'cluster.name'                            => node['elasticsearch']['cluster_name'],
    'discovery.ec2.tag.opsworks:stack'        => node['elasticsearch']['stack_name'],
    'discovery.zen.minimum_master_nodes'      => node['elasticsearch']['instance_count'],
    'gateway.expected_nodes'                  => node['elasticsearch']['instance_count']

  )
end

elasticsearch_service 'elasticsearch' do
  service_actions [:enable, :start]
end

node['elasticsearch']['plugins'].each do |plugin|
  elasticsearch_plugin plugin['name'] do
    url plugin['url'] if plugin['url']
    notifies :restart, 'elasticsearch_service[elasticsearch]', :delayed
  end
end
