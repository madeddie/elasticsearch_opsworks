#
# Cookbook Name:: elasticsearch_opsworks
# Recipe:: cronjobs
#

include_recipe 'elasticsearch_opsworks::docker'

# backup jobs
cron 'backup_create' do
  minute '1'
  hour '2'
  command "docker run --rm bobrik/curator:latest --master-only --host 172.17.0.1 snapshot --repository lgi-es-backup indices --regex '^production-(activity|default-smart-card-setting|remotecontrol-recordings)-.*$'"
end

cron 'backup_delete' do
  minute '10'
  hour '2'
  command 'docker run --rm bobrik/curator:latest --master-only --host 172.17.0.1 delete snapshots --repository lgi-es-backup --older-than 30 --time-unit days'
end

# index cleanup jobs
cron 'cleanup_logstash' do
  minute '1'
  hour '1'
  command "docker run --rm bobrik/curator:latest --master-only --host 172.17.0.1 delete indices --prefix logstash- --older-than 30 --time-unit days --timestring '\\%Y.\\%m.\\%d'"
end

cron 'cleanup_marvel' do
  minute '1'
  hour '0'
  command "docker run --rm bobrik/curator:latest --master-only --host 172.17.0.1 delete indices --prefix .marvel- --older-than 30 --time-unit days --timestring '\\%Y.\\%m.\\%d'"
end
