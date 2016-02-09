#
# utility var
#
cvc = Chef::VersionConstraint

#
# Recipe Name:: elasticsearch_opsworks::elasticsearch
#

default['elasticsearch']['version'] = '1.7.3'
default['elasticsearch']['install_type'] = 'tarball'

es_version = node['elasticsearch']['version']
es_plugins = case
             when cvc.new('~> 1.6').include?(es_version)
               [
                 { 'name' => 'gui',       'url' => 'jettro/elasticsearch-gui/1.3.0' },
                 { 'name' => 'head',      'url' => 'mobz/elasticsearch-head/1.x' },
                 { 'name' => 'kopf',      'url' => 'lmenezes/elasticsearch-kopf/1.0' },
                 { 'name' => 'marvel',    'url' => 'elasticsearch/marvel/latest' },
                 { 'name' => 'migration', 'url' => 'elastic/elasticsearch-migration' },
                 { 'name' => 'cloud-aws', 'url' => 'elasticsearch/elasticsearch-cloud-aws/2.7.1' }
               ]
             when cvc.new('~> 2.0').include?(es_version)
               [
                 { 'name' => 'cloud-aws' },
                 { 'name' => 'license' },
                 { 'name' => 'marvel-agent' },
                 { 'name' => 'watcher' },
                 { 'name' => 'gui',  'url' => 'jettro/elasticsearch-gui' },
                 { 'name' => 'head', 'url' => 'mobz/elasticsearch-head' },
                 { 'name' => 'kopf', 'url' => 'lmenezes/elasticsearch-kopf/2.0' }
               ]
             end
default['elasticsearch']['plugins'] = es_plugins

#
# Recipe Name:: java::default
#

default['java']['jdk_version'] = '8'
default['java']['install_flavor'] = 'oracle'
default['java']['jdk']['8']['x86_64']['url'] = 'https://s3-eu-west-1.amazonaws.com/jvm-registry/jdk-8u71-linux-x64.tar.gz'
default['java']['jdk']['8']['x86_64']['checksum'] = '9bdb947fccf31e6ad644b7c1e3c658291facf819e4560a856e4d93bd686e58a2'
default['java']['oracle']['accept_oracle_download_terms'] = true

#
# Recipe Name:: elasticsearch_opsworks::kibana
#

case
when cvc.new('~> 1.6').include?(es_version)
  default['kibana_version'] = '4.1'
  default['kibana_image'] = 'kibana'
when cvc.new('~> 2.0.0').include?(es_version)
  default['kibana_version'] = '4.2'
  default['kibana_image'] = 'madtech/kibana_marvel'
when cvc.new('~> 2.1.0').include?(es_version)
  default['kibana_version'] = '4.3'
  default['kibana_image'] = 'madtech/kibana_marvel'
when cvc.new('~> 2.2.0').include?(es_version)
  default['kibana_version'] = '4.4'
  default['kibana_image'] = 'madtech/kibana_marvel'
end

#
# Recipe Name:: elasticsearch_opsworks::logstash
#

default['logstash_version'] = '2.2'

#
# Recipe Name:: monitor::client
#

default['sensu']['rabbitmq']['host'] = "sensu.#{node['lgi']['domain_name']}"
default['monitor']['client'] = "#{node['hostname']}.#{node['lgi']['stack_name']}"
default['monitor']['additional_plugins'] = {
  'sensu-plugins-docker'        => '0.0.4',
  'sensu-plugins-elasticsearch' => '0.4.2',
  'sensu-plugins-java'          => '0.0.3' # don't forget to update the sudo_commands down below and sensu.rb recipe
}
default['monitor']['subscriptions'] = %w(system elasticsearch)
default['monitor']['sudo_commands'] <<
  '/opt/sensu/embedded/lib/ruby/gems/2.0.0/gems/sensu-plugins-java-0.0.3/bin/metrics-jstat.py'

#
# Recipe Name:: docker::default
#

default['docker']['version'] = '1.9.1'
