#
# Cookbook Name:: elasticsearch_opsworks
# Recipe:: default
#

include_recipe 'elasticsearch_opsworks::elasticsearch'
include_recipe 'elasticsearch_opsworks::elasticsearch_nginx'

if node['enable_kibana'] == 'true' || node['enable_kibana']
  include_recipe 'elasticsearch_opsworks::kibana'
  include_recipe 'elasticsearch_opsworks::logstash'
end
