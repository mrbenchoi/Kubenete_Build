#
# Cookbook:: Kubernetes
# Recipe:: kube-master
#
# Copyright:: 2017, The Authors, All Rights Reserved.

template "/etc/kubernetes/config" do
	source "kube-master-config.erb"
end

template "/etc/etcd/etcd.conf" do
	source "kube-master-etcd.conf.erb"
end

template "/etc/kubernetes/apiserver" do
	source "kube-master-apiserver.erb"
end

service 'etcd' do
  action :start
end

execute 'etcdctl mkdir' do
  command 'etcdctl mkdir /kube-centos/network && etcdctl mk /kube-centos/network/config "{ \"Network\": \"172.30.0.0/16\", \"SubnetLen\": 24, \"Backend\": { \"Type\": \"vxlan\" } }"'
  not_if ('etcdctl ls /kube-centos/network/config')
end

template "/etc/sysconfig/flanneld" do
	source "flanneld.erb"
end

service 'etcd' do
	action [:enable,:start]
end

service 'kube-apiserver' do
	action [:enable,:start]
end

service 'kube-controller-manager' do
	action [:enable,:start]
end

service 'kube-scheduler' do
	action [:enable,:start]
end

service 'flanneld' do
	action [:enable,:start]
end