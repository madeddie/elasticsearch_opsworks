#
# Cookbook Name:: elasticsearch_opsworks
# Recipe:: sensu
#

include_recipe 'monitor::client'

sensu_check 'metrics-es-node-graphite' do
  type 'metric'
  command "metrics-es-node-graphite.rb --scheme #{node['lgi']['stack_name']}.#{node['hostname']}.elasticsearch"
  handlers ['metrics']
  standalone true
  interval 60
end

sensu_check 'metrics-jstat' do
  type 'metric'
  command "sudo -u elasticsearch /opt/sensu/embedded/lib/ruby/gems/2.0.0/gems/sensu-plugins-java-0.0.3/bin/metrics-jstat.py -H localhost -j Elasticsearch -g #{node['lgi']['stack_name']}.#{node['hostname']}"
  handlers ['metrics']
  standalone true
  interval 60
end
