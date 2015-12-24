#
# utility var
#
cvc = Chef::VersionConstraint

#
# Recipe Name:: elasticsearch
#

default['elasticsearch']['version'] = '1.7.3'

es_version = node['elasticsearch']['version']
es_plugins = case
             when cvc.new('~> 1.6').include?(es_version)
               [
                 { 'name' => 'gui',       'url' => 'jettro/elasticsearch-gui/1.3.0' },
                 { 'name' => 'head',      'url' => 'mobz/elasticsearch-head' },
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
                 { 'name' => 'gui',  'url' => 'jettro/elasticsearch-gui/2.0.0' },
                 { 'name' => 'kopf', 'url' => 'lmenezes/elasticsearch-kopf/2.0' }
               ]
             end
default['elasticsearch']['plugins'] = es_plugins

#
# Recipe Name:: java
#

default['java']['jdk_version'] = '8'
default['java']['install_flavor'] = 'oracle'
default['java']['jdk']['8']['x86_64']['url'] = 'https://s3-eu-west-1.amazonaws.com/jvm-registry/jdk-8u65-linux-x64.tar.gz'
default['java']['jdk']['8']['x86_64']['checksum'] = '88db2aacdc222c2add4d92822f528b7a2101552272db4487f33b38b0b47826e7'
default['java']['oracle']['accept_oracle_download_terms'] = true

#
# Recipe Name:: kibana
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
end

#
# Recipe Name:: logstash
#

default['logstash_version'] = '2.1'
