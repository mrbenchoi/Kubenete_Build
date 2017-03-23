#
# Cookbook Name:: Kubernetes
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#cookbook_file '/etc/yum.repos.d/virt7-docker-common-release.repo' do
#  source 'virt7-docker-common-release.repo'
#end

yum_repository 'virt7-docker-common-release' do
  description 'virt7-docker-common-release'
  baseurl 'http://cbs.centos.org/repos/virt7-docker-common-release/x86_64/os/'
  gpgcheck false
  enabled true
end

package 'Kubernetes packages' do
	package_name ['ntp', 'kubernetes', 'etcd', 'flannel']
	action :install
end

node_info = search(:node, "role:*")

file '/etc/hosts' do
        hostfile = "127.0.0.1	#{node['hostname']} #{node['hostname']}\n"
        hostfile = hostfile + "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4\n"
	hostfile = hostfile + "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6\n"
	hostfile = hostfile + "192.168.10.88	chef-server chef-server.local\n"
        ip_address = ""
        host_name = ""
        node_info.each do | kube_node |
                ip_address = kube_node['network']['interfaces']['eth0']['addresses'].keys.select { |a| a[/\A\d+\.\d+\.\d+\.\d+\Z/] }.first
                host_name = kube_node['hostname']
                hostfile = hostfile + "#{ip_address}    #{host_name}\n"
        end
        content "#{hostfile}\n"
end
