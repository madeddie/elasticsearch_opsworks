#
# Cookbook Name:: elasticsearch_opsworks
# Recipe:: docker
#

# Add docker repo
include_recipe 'apt-docker::default'

# Install and run specific version of Docker Engine
docker_service 'default' do
  version node['docker']['version']
  install_method 'package'
  service_manager 'auto'
  action [:create, :start]
end
