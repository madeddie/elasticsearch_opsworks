#
# Cookbook Name:: elasticsearch_opsworks
# Recipe:: kibana
#

include_recipe 'elasticsearch_opsworks::docker'

# Pull specific tag of image
docker_image 'kibana' do
  repo node['kibana_image']
  tag node['kibana_version']
  action :pull
  notifies :redeploy, 'docker_container[kibana]', :immediately
end

# Run container exposing ports
docker_container 'kibana' do
  container_name 'kibana'
  host_name node['hostname']
  repo node['kibana_image']
  tag node['kibana_version']
  detach true
  kill_after 30
  port '5601:5601'
  env 'ELASTICSEARCH_URL=http://172.17.0.1:9200'
  action :run
end

include_recipe 'nginx::default'

cookbook_file '/etc/nginx/sites-available/kibana' do
  source 'nginx_kibana.conf'
end

nginx_site 'kibana' do
  enable true
  notifies :reload, 'service[nginx]', :delayed
end
