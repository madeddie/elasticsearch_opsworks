#
# Cookbook Name:: elasticsearch_opsworks
# Recipe:: elasticsearch_nginx
#

include_recipe 'nginx::default'

cookbook_file '/etc/nginx/sites-available/elasticsearch' do
  source 'nginx_elasticsearch.conf'
end

nginx_site 'elasticsearch' do
  enable true
  notifies :reload, 'service[nginx]', :delayed
end
