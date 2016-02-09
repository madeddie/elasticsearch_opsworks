#
# Cookbook Name:: elasticsearch_opsworks
# Recipe:: logstash
#

include_recipe 'elasticsearch_opsworks::docker'

# Pull specific tag of image
docker_image 'logstash' do
  tag node['logstash_version']
  action :pull
  notifies :redeploy, 'docker_container[logstash]', :immediately
end

# Run container exposing ports
docker_container 'logstash' do
  container_name 'logstash'
  host_name node['hostname']
  tag node['logstash_version']
  detach true
  port ['5043:5043', '5959:5959']
  command '-e \'
    input {
      stdin { type => "stdin" codec => "json_lines" }
      tcp { type => "tcp-input" port => "5959" codec => "json_lines" }
    }
    filter {
      mutate {
        gsub => [ "__REALTIME_TIMESTAMP", ".{3}$", "" ]
        rename => [ "MESSAGE", "message" ]
        convert => { "@version" => "string" }
      }
      if ( [message] =~ /^{".*}$/ ) {
        json {
          source => "message"
          add_tag => [ "json" ]
        }
      }
      date {
        match => [ "__REALTIME_TIMESTAMP", "UNIX_MS"]
        timezone => "UTC"
      }
    }
    output {
      elasticsearch {
        hosts => ["172.17.0.1:9200"]
      }
    }\''
  action :run
end
