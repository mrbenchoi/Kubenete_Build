name 'kube-minion-role'
description 'Kubernetes Minion Role'
run_list 'recipe[Kubernetes::default]', 'recipe[Kubernetes::kube-minion]'