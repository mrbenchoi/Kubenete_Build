#
# Cookbook:: Kubernetes
# Recipe:: kube-minion
#
# Copyright:: 2017, The Authors, All Rights Reserved.

template "/etc/kubernetes/kubelet" do
	source "kubelet.erb"
end

template "/etc/sysconfig/flanneld" do
	source "flanneld.erb"
end

service 'kube-proxy' do
	action [:enable,:start]
end

service 'kubelet' do
	action [:enable,:start]
end

service 'flanneld' do
	action [:enable,:start]
end

service 'docker' do
	action [:enable,:start]
end
