#
# Cookbook Name:: elasticsearch_opsworks
# Recipe:: base_settings
#

directory '/etc/lgi' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

%w(stack_name domain_name environment).each do |var|
  file "/etc/lgi/#{var}" do
    content node['lgi'][var]
    owner 'root'
    group 'root'
    mode '0755'
  end
end
