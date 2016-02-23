#
# Cookbook Name:: elasticsearch_opsworks
# Recipe:: default
#

include_recipe 'elasticsearch_opsworks::base_settings'
include_recipe 'elasticsearch_opsworks::elasticsearch'
include_recipe 'elasticsearch_opsworks::elasticsearch_nginx'

if node['enable_kibana'] == 'true' || node['enable_kibana']
  include_recipe 'elasticsearch_opsworks::kibana'
end

if node['enable_logstash'] == 'true' || node['enable_logstash']
  include_recipe 'elasticsearch_opsworks::logstash'
end

include_recipe 'elasticsearch_opsworks::sensu'
include_recipe 'elasticsearch_opsworks::cronjobs'
