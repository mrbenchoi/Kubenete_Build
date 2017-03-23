name 'kube-master-role'
description 'Kubernetes Master Role'
run_list 'recipe[Kubernetes::default]', 'recipe[Kubernetes::kube-master]'
