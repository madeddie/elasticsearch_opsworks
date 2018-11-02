# DEPRECATED

This module hasn't been maintained nor used by me for some time. Security warnings have started popping up.

Use only as inspiration or starting point for your own projects.

[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)

# elasticsearch_opsworks

Installs ElasticSearch. Specifically to be used within an OpsWorks stack on AWS.

## Supported Platforms

Tested on:

 - ubuntu 14.04

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['elasticsearch']['version']</tt></td>
    <td>String</td>
    <td>ElasticSearch version</td>
    <td><tt>1.7.5</tt></td>
  </tr>
  <tr>
    <td><tt>['elasticsearch']['cluster_name']</tt></td>
    <td>String</td>
    <td>Name of ElasticSearch cluster</td>
    <td><tt>empty</tt></td>
  </tr>
 <tr>
    <td><tt>['elasticsearch']['instance_count']</tt></td>
    <td>String</td>
    <td>Number of hosts in cluster, used for host count and min master count</td>
    <td><tt>empty</tt></td>
  </tr>
  <tr>
    <td><tt>['lgi']['domain_name']</tt></td>
    <td>String</td>
    <td>Toplevel domain of CF stack</td>
    <td><tt>empty</tt></td>
  </tr>
  <tr>
    <td><tt>['lgi']['stack_name']</tt></td>
    <td>String</td>
    <td>Name of OpsWorks stack, used by AWS plugin to find other hosts of cluster</td>
    <td><tt>empty</tt></td>
  </tr>
  <tr>
    <td><tt>['enable_kibana']</tt></td>
    <td>Boolean/String</td>
    <td>Run kibana docker container, also add vhost to nginx for kibana.*</td>
    <td><tt>empty</tt></td>
  </tr>
  <tr>
    <td><tt>['enable_logstash']</tt></td>
    <td>Boolean/String</td>
    <td>Run logstash docker container</td>
    <td><tt>empty</tt></td>
  </tr>
</table>

## Usage

### elasticsearch_opsworks::default

Include `elasticsearch_opsworks` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[elasticsearch_opsworks::default]"
  ]
}
```

## License and Authors

Author:: Edwin Hermans (<edwin@madtech.cx>)
